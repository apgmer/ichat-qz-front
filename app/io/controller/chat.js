/**
 * Created by guoxiaotian on 2017/5/3.
 */
'use strict';

module.exports = () => {
    let _sockets = {};
    return function* () {
        const message = this.args[0];
        // console.log('chat :', message + ' : ' + process.pid);
        // // const say = yield this.service.user.say();
        // this.socket.emit('res', "xxx"+message);
        //
        const socket = this.socket;
        let data;

        console.log(message)

        if(typeof message !== "object"){
            try{
                data = JSON.parse(message);
            }catch (e){
                console.log("json error");
                data = {};
            }
        }else{
            data = message
        }

        switch (data.type){
            case 'login':
                let d = {
                    type:"login",
                    success:true
                };
                socket.webrtcname = data.name;
                _sockets[data.name] = socket;
                socket.emit('webrtcMsg',JSON.stringify(d));
                break;

            case 'request':
                console.log(data.isMobile)
                let sr = _sockets[data.name]
                if (sr !== null){
                    sr.emit('webrtcMsg',JSON.stringify({
                        type:'request',
                        name:socket.webrtcname, //当前名字
                        isMobile:data.isMobile?true:false
                    }))
                }
                break;
            case 'ok':
                let so = _sockets[data.name];
                if(null !== so){
                    so.emit('webrtcMsg',JSON.stringify({
                        type: "ok"
                    }))
                }
                break;

            case 'offer':

                // console.log("收到offer 如下")
                // console.log(data)
                let s = _sockets[data.name];
                if (s !== null){
                    s.emit('webrtcMsg',JSON.stringify({
                        type:'offer',
                        offer:data.offer,
                        name:socket.webrtcname
                    }))
                }
                break;

            case 'answer':
                let s1 = _sockets[data.name];
                if (null !== s1){
                    s1.emit('webrtcMsg',JSON.stringify({
                        type: "answer",
                        answer: data.answer
                    }))
                }
                break;

            case 'candidate':
                console.log("收到candidate 如下")
                console.log(data)
                let s2 = _sockets[data.name];
                if(null !== s2){
                    s2.emit('webrtcMsg',JSON.stringify({
                        type: "candidate",
                        candidate: data.candidate
                    }))
                }
                break;


            case 'refuse':
                let s3 = _sockets[data.name];
                if(null !== s3){
                    s3.emit('webrtcMsg',JSON.stringify({
                        type: "refuse"
                    }))
                }
                break;

            // case 'leave':
            //     let s3 = _sockets[data.name];
            //     break;


        }

    };
};
