'use strict';

module.exports = app => {
    class HomeController extends app.Controller {

        * index() {
            yield this.ctx.render('home/index.tpl', {isLogin: !!(this.ctx.session.user)});
        }

        * login() {
            if (this.ctx.session.user) {
                this.ctx.redirect('/family');
            }
            yield this.ctx.render('home/login.tpl');
        }

        * register() {
            yield this.ctx.render('home/register.tpl')
        }

        * loginAct() {
            const ctx = this.ctx;
            let username = ctx.request.body.phone;
            let pass = ctx.request.body.password;
            const userInfo = yield ctx.service.user.find(username, pass);
            if (null !== userInfo) {
                ctx.session.user = userInfo;
                ctx.body = {
                    success: true
                }
            } else {
                ctx.body = {
                    success: false
                }
            }
        }
        * sendRegCode() {
            const ctx = this.ctx;
            let phone = ctx.request.body.phone;
            const flag = yield ctx.service.user.sendRegCode(phone);
            ctx.body = {
                success: flag
            }
        }

        * registerAct() {
            const ctx = this.ctx;
            let phone = ctx.request.body.phone;
            let regcode = ctx.request.body.regcode;
            let nickname = ctx.request.body.nickname;
            let role = ctx.request.body.role;
            let password = ctx.request.body.password;

            const flag = yield ctx.service.user.reguser(phone, regcode, nickname, role, password);
            ctx.body = {
                success: flag
            }
        }

        * keepOnline() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                const flag = yield ctx.service.user.keepOnline(ctx.session.user.id)
                ctx.body = {success: flag}
            }
        }

        * getLoginUser() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                ctx.body = ctx.session.user;
            }
        }

        * logout() {
            this.ctx.session = null;
            this.ctx.redirect('/');
        }
    }
    return HomeController;
};