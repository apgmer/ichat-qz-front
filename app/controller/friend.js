/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class FriendController extends app.Controller {

        /**
         * 用户搜索
         */
        * friendSearch() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let queryKey = ctx.query.name;
                const friendList = yield ctx.service.friend.friendSearch(queryKey);

                for (let i = 0, flag = true, len = friendList.length; i < len; flag ? i++ : i) {
                    if (friendList[i] && friendList[i].userinfo.id === ctx.session.user.id) {
                        friendList.splice(i, 1);
                        flag = false;
                    } else {
                        flag = true;
                    }
                }
                ctx.body = friendList;
            }
        }

        /**
         * 发送添加好友请求
         */
        * addFriendReq() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let friendid = ctx.query.friendid;
                let nowFriendArr = ctx.session.user.friends;
                let flag = false;
                if (nowFriendArr !== null) {
                    if (nowFriendArr.indexOf(friendid) === -1) {
                        flag = yield ctx.service.friend.addFriendReq(ctx.session.user.id, friendid);
                    }
                } else {
                    flag = yield ctx.service.friend.addFriendReq(ctx.session.user.id, friendid);
                }

                ctx.body = {
                    success: flag
                }
            }
        }

        /**
         * 处理接受到的请求
         */
        * dealNotify() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let msgid = ctx.query.msgid;
                let status = ctx.query.status;
                const flag = yield ctx.service.friend.dealRecvMsg(msgid, status)
                ctx.body = {
                    success: flag
                }
            }
        }

        /**
         * 将消息状态改为完成
         */
        * doneNotify() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let msgid = ctx.query.msgid;
                const flag = yield ctx.service.friend.doneMsg(msgid, ctx.session.user.id)
                ctx.body = {
                    success: flag
                }
            }
        }


    }

    return FriendController;
};