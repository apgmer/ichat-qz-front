/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {

    class Friend extends app.Service {
        constructor(ctx) {
            super(ctx);
            this.serverUrl = this.config.serverUrl;
        }

        * getFamilyInfos(fid) {
            return yield this.familyRequest("familyInfo?fid=" + fid)
        }
        * getFamilyStatusInfos(fid) {
            return yield this.familyRequest("familyInfos?fid=" + fid)
        }

        * delMem(memid, fid) {
            return yield this.familyRequest("delFamilyMem?memId=" + memid + "&fid=" + fid)
        }

        * addMem(user, fid) {
            const opt = {
                method: 'POST',
                contentType: 'json',
                data: user
            };
            const res = yield this.familyRequest("addFamilyMem?fid=" + fid, opt)
            console.log(user)
            console.log(res)
            return res;
        }

        * familyRequest(api, opts) {
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