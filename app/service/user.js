/**
 * Created by guoxiaotian on 2017/5/4.
 */
module.exports = app => {
    class User extends app.Service {

        constructor(ctx) {
            super(ctx);
            this.serverUrl = this.config.serverUrl;
        }

        //use
        * find(username, pass) {
            const opt = {
                method: 'POST',
                contentType: 'json',
                data: {
                    phone: username,
                    pass: pass
                }
            };
            const res = yield this.userRequest("/login", opt);
            console.log(res)
            let userInfo = null;
            if (res.success) {
                userInfo = res.data[0];
            }
            return userInfo;
        }
        //use
        * reguser(phone, regcode, nickname, role, password) {
            const opt = {
                method: 'POST',
                contentType: 'json',
                data: {
                    phone: phone,
                    nickname: nickname,
                    role: role,
                    pass: password
                }
            };
            const res = yield this.userRequest("/register?regcode="+regcode, opt);
            return res.success;
        };

        //use
        * sendRegCode(phone) {
            const res = yield this.userRequest('/regcode?phone=' + phone, {});
            return res.success;
        }

        //use
        * keepOnline(uid) {
            const res = yield this.userRequest('/keepOnline?uid=' + uid, {
                contentType: 'JSON'
            })
            console.log(res)
            return res.success;
        }

        * findUserById(uid) {
            const opt = {
                contentType: 'JSON'
            }
            const res = yield this.userRequest("/user/findById?uid=" + uid);
            if (res.success) {
                return res.data;
            } else {
                return null;
            }
        }


        * userRequest(api, opts) {
            const options = Object.assign({
                dataType: 'json',
                timeout: ['30s', '30s'],
            }, opts);

            const result = yield this.ctx.curl(`${this.serverUrl}/${api}`, options);
            return result.data;
        }
    }


    return User;
};