/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class ChatController extends app.Controller {

        * showChatView() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.redirect("/");
            } else {
                const uid = ctx.session.user.id;
                const friendList = yield ctx.service.friend.findFriendByUid(uid);
                yield ctx.render('chat/chat.tpl', {
                    isLogin: true,
                    friends: friendList
                    // sendNotifys: sendNotifyList,
                    // recvNotifys: recvNotifyList,
                })
            }
        }


        * showNotifyView() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.redirect("/")
            } else {
                const notifies = yield ctx.service.friend.findNotifiesDetail(ctx.session.user.id)
                yield ctx.render('home/notify.tpl', {
                    notifies: notifies,
                    isLogin: true
                })
            }
        }
    }

    return ChatController;
};