/**
 * Created by guoxiaotian on 2017/5/5.
 */
'use strict';

// module.exports = app => {
//     class HomeController extends app.Controller {
//
//         constructor(ctx){
//             super(ctx);
//         }
//
//         * index() {
//             yield this.ctx.render('home/index.tpl');
//         }
//
//         * login() {
//             yield this.ctx.render('home/login.tpl');
//         }
//
//         * register() {
//             yield this.ctx.render('home/register.tpl')
//         }
//
//         * chat() {
//             yield this.ctx.render('chat/chat.tpl', {})
//         }
//
//         * loginAct() {
//             const ctx = this.ctx;
//             let username = ctx.request.body.username;
//             let pass = ctx.request.body.password;
//             const userInfo = yield ctx.service.user.find(username, pass);
//             if (null === userInfo) {
//                 ctx.session.user = userInfo;
//                 ctx.body = {
//                     success: true
//                 }
//             } else {
//                 ctx.body = {
//                     success: false
//                 }
//             }
//         }
//     }
//     return HomeController;
// };
module.exports = app =>{
    class UserController extends app.Controller{
        constructor(ctx){
            super(ctx);
        }

    }

    return UserController;
};