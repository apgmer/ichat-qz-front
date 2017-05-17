/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {

    class Friend extends app.Service {
        constructor(ctx) {
            super(ctx);
            this.serverUrl = this.config.serverUrl;
        }

        /**
         * 根据当前用户 查找朋友
         * @param uid
         * @returns {null}
         */
        * findFriendByUid(uid) {
            const res = yield this.friendRequest("friend/getfriends?uid=" + uid)
            if (res.success) {
                return res.data;
            } else {
                return null;
            }
        }


        /**
         * 用户搜索
         * @param name
         * @returns {null}
         */
        * friendSearch(name) {
            const res = yield this.friendRequest('user/search?name=' + name);
            if (res.success) {
                return res.data;
            } else {
                return null;
            }
        }

        /**
         * 发送添加好友请求
         * @param nowuid 当前用户id
         * @param friendid 好友id
         * @returns {null}
         */
        * addFriendReq(nowuid, friendid) {
            if (nowuid === friendid) return null;
            const res = yield this.friendRequest('friend/addReq', {
                method: 'POST',
                data: {
                    srcId: nowuid,
                    desId: friendid
                }
            })
            return res.success;
        }


        /**
         * 查询收到的通知
         * @param uid
         * @returns {null}
         */
        * findRecvNotify(uid) {
            const res = yield this.friendRequest('friend/getfriendmsg?uid=' + uid);
            if (res.success) {
                return res.data.length === 0 ? null : res.data;
            } else {
                return null;
            }
        }

        /**
         * 查询当前用户的所有通知
         * @param uid
         * @returns {{recvList: *, sendList: *}}
         */
        * findNotifiesDetail(uid) {
            const recvList = yield this.findRecvNotify(uid);
            const sendList = yield this.findSendNotify(uid)
            if (recvList !== null) {
                for (let i = 0; i < recvList.length; i++) {
                    recvList[i].userinfo = yield this.ctx.service.user.findUserById(recvList[i].srcId);
                }
            }
            if (sendList !== null) {
                for (let i = 0; i < sendList.length; i++) {
                    sendList[i].userinfo = yield this.ctx.service.user.findUserById(sendList[i].desId)
                }
            }
            return {
                recvList: recvList,
                sendList: sendList
            }
        }

        /**
         * 查询自己发送的通知
         * @param uid
         * @returns {null}
         */
        * findSendNotify(uid) {
            const res = yield this.friendRequest('friend/getNotify?uid=' + uid);
            if (res.success) {
                return res.data.length === 0 ? null : res.data;
            } else {
                return null;
            }
        }

        /**
         * 处理接受到的请求
         * @param msgid 请求id
         * @param status 处理结果
         */
        * dealRecvMsg(msgid, status) {
            const res = yield this.friendRequest('friend/dealfriendmsg', {
                data: {
                    id: msgid,
                    status: status
                },
                method: 'POST'
            })
            return res.success;
        }

        /**
         * 将消息状态改为完成
         * @param msgid
         * @param uid
         */
        * doneMsg(msgid, uid) {
            const res = yield this.friendRequest('friend/setNotifyDone?uid=' + uid + '&msgid=' + msgid);
            return res.success;
        }

        * friendRequest(api, opts) {
            const options = Object.assign({
                contentType: 'json',
                dataType: 'json',
                timeout: ['30s', '30s'],
            }, opts);

            const result = yield this.ctx.curl(`${this.serverUrl}/${api}`, options);
            return result.data;
        }
    }

    return Friend;

};