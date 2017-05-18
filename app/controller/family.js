/**
 * Created by guoxiaotian on 2017/5/17.
 */
'use strict';

module.exports = app => {
    class FamilyController extends app.Controller {
        * showFamilyView() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.redirect("/");
            } else {
                let res = yield ctx.service.family.getFamilyInfos(ctx.session.user.familyId);
                yield ctx.render('family/index.tpl', {memInfos: res.data.mems})
            }
        }

        * showFamilyChatView() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.redirect("/");
            } else {
                let res = yield ctx.service.family.getFamilyStatusInfos(ctx.session.user.familyId);
                let data;
                if (res.data.length == 1) {
                    data = null;
                } else {
                    data = res.data
                }
                yield ctx.render('family/chat.tpl', {memInfos: data})
            }
        }

        * delMem() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403
            } else {
                let res = yield ctx.service.family.delMem(ctx.query.id, ctx.session.user.familyId);
                ctx.body = {
                    success: res.success
                }
            }
        }

        * addMem() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403
            } else {
                let user = {
                    phone: ctx.request.body.phone,
                    pass: ctx.request.body.pass,
                    role: ctx.request.body.role,
                    nickname: ctx.request.body.nickname
                }
                let res = yield ctx.service.family.addMem(user, ctx.session.user.familyId);
                ctx.body = {
                    success: res.success
                }

            }
        }


    }

    return FamilyController;
};