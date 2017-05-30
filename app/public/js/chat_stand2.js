/**
 * Created by guoxiaotian on 2017/5/18.
 */

navigator.getUserMedia = navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia;
window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
window.RTCSessionDescription = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
window.RTCIceCandidate = window.RTCIceCandidate || window.mozRTCIceCandidate || window.webkitRTCIceCandidate;
var audio = new Audio('/public/mp3/bell.mp3');
// audio.play();

let yourConn;
let stream;
let connectedUser;
let isLogin = false;
let isCallTo = false;

let configuration = {
    // "iceServers": [{"url": "turn:112.74.57.118:3478", "username": "username1", "credential": "password1"}]
    "iceServers": [
        {"url": 'stun:stun.ekiga.net'}
    ]
};
// let callBtn = document.querySelector('#callBtn');
// let localVideo = document.querySelector('#localVideo');
// let remoteVideo = document.querySelector('#remoteVideo');

// const socket = io.connect('http://192.168.1.103');
// const socket = io.connect('http://192.168.1.104:7001');
const socket = io.connect('https://localhost');
// const socket = io('http://localhost',{})
console.log(socket)
socket.on('connect', function () {

    send({
        type: "login",
        name: loginUserId
    })

});
//
socket.on('webrtcMsg', function (data) {
    let jsonData = JSON.parse(data);
    switch (jsonData.type) {
        case 'login':
            // handleLogin(jsonData.success);
            isLogin = true;
            break;

        case 'request':
            handleRequest(jsonData)
            break;
        case 'ok':
            handleOkReq(jsonData);
            break;

        case 'offer':
            console.log("recv offer")
            handleOffer(jsonData.offer, jsonData.name);
            break;

        case 'answer':
            console.log("recv answer")
            handleAnswer(jsonData.answer);
            break;

        case 'candidate':
            console.log('recv candidate')
            handleCandidate(jsonData.candidate);
            break;
        case 'refuse':
            handlerRefuse();
            break;
        case 'leave':
            alert('对方已离开');
            leaveAction();
            break;
        case 'loc':
            changeLoc(jsonData);
            break;

    }
});
//
let callTo = function (friendid) {
    audio.play();
    connectedUser = friendid
    send({type: 'request', name: friendid, isMobile: false})

}

let handleRequest = function (jsonData) {
    console.log("ercv request " + jsonData)
    console.log(jsonData)
    audio.play();
    if (!isLogin) {
        alert('socket 服务器链接失败。')
        audio.pause();
        return;
    }

    layer.confirm('您的好友请求与您视频通话，是否接受', function (index) {
        audio.pause()
        layer.close(index);
        startChat(jsonData.name, jsonData.isMobile);

        send({
            type: 'ok',
            name: jsonData.name
        })
        handleLogin(isLogin, function () {

        })

    }, function (index) {
        layer.close(index)
        send({
            name: jsonData.name,
            type: "refuse"
        });
    });


}
let handleOkReq = function (jsonData) {
    let friendid = connectedUser
    startChat(friendid, jsonData.isMobile);

    isCallTo = true;
    audio.pause();

    console.log("recv ok " + jsonData)
    // 将自己的摄像头显示在屏幕上
    handleLogin(isLogin, function () {

        if (!jsonData.isMobile) {
            let callToUsername = friendid;

            if (callToUsername.length > 0) {

                connectedUser = callToUsername;

                // create an offer
                yourConn.createOffer(function (offer) {
                    console.log("create offer")
                    send({
                        type: "offer",
                        offer: offer
                    });

                    yourConn.setLocalDescription(offer);
                }, function (error) {
                    alert("Error when creating an offer");
                });


            }
        }
    });
}


var constraints = window.constraints = {
    audio: true,
    video: true
};

let handleLogin = function (success, callback) {
    if (!success) {
        alert('登陆失败');
    } else {
        //**********************
        //Starting a peer connection
        //**********************

        //getting local video stream
        // navigator.webkitGetUserMedia({ video: true, audio: true }, function (myStream) {
        // navigator.getUserMedia({video: true, audio: true}, function (myStream) {
        navigator.getUserMedia(constraints, function (myStream) {

            // navigator.getUserMedia(constraints, function (myStream) {
            stream = myStream;

            //displaying local video stream on the page
            localVideo.src = window.URL.createObjectURL(stream);


            //using Google public stun server


            // iceServer => {
            //     urls: 'turn:domain.com:3478',
            //         credential: 'orignal-password', // NOT Hash
            //         username: 'username'
            // }

            // yourConn = new webkitRTCPeerConnection(configuration);

            if (!yourConn) {
                yourConn = new RTCPeerConnection(configuration);
            }

            // yourConn = new RTCPeerConnection(configuration);

            // setup stream listening
            yourConn.addStream(stream);
            // yourConn.addTrack(myStream.getTracks()[0],stream);

            //when a remote user adds stream to the peer connection, we display it
            yourConn.onaddstream = function (e) {
                remoteVideo.src = window.URL.createObjectURL(e.stream);
            };

            // Setup ice handling
            yourConn.onicecandidate = function (event) {
                if (event.candidate) {
                    console.log('send candidate')
                    send({
                        type: "candidate",
                        candidate: event.candidate
                    });
                    console.log("发送 candidate")
                }
            };
            callback(true)

        }, function (error) {
            console.log(error);
            callback(false)
        });
    }
};

let handleOffer = function (offer, name) {
    console.log(offer)

    connectedUser = name;
    yourConn.setRemoteDescription(new RTCSessionDescription(offer));

    //create an answer to an offer
    yourConn.createAnswer(function (answer) {
        yourConn.setLocalDescription(answer);
        console.log('send answer')
        send({
            type: "answer",
            answer: answer
        });


    }, function (error) {
        console.log(error);
        alert("Error when creating an answer");
    });


};

let handlerRefuse = function () {
    audio.pause();
    var track = stream.getTracks()[0];  // if only one media track
    track.stop();
    $('#chatPanel').empty();
    layer.alert('您的好友拒绝和您聊天。')
    localVideo.src = null;
    connectedUser = null;
    yourConn.close();
    yourConn.onicecandidate = null;
    yourConn.onaddstream = null;
}

let handleAnswer = function (answer) {
    yourConn.setRemoteDescription(new RTCSessionDescription(answer));
};
//when we got an ice candidate from a remote user
let handleCandidate = function (candidate) {
    if (!yourConn) {
        yourConn = new RTCPeerConnection(configuration);
    }
    yourConn.addIceCandidate(new RTCIceCandidate(candidate));

};

let send = function (message) {
    //attach the other peer username to our messages
    if (connectedUser) {
        message.name = connectedUser;
    }
    socket.emit('webrtcMsg', JSON.stringify(message));

//            conn.send(JSON.stringify(message));
};
var leave = function () {
    send({
        type: "leave"
    });
    leaveAction()
}
var leaveAction = function () {
    var track = stream.getTracks()[0];  // if only one media track
    track.stop();
    remoteVideo.src = null
    localVideo.src = null;
    connectedUser = null;
    yourConn.close();
    yourConn.onicecandidate = null;
    yourConn.onaddstream = null;
    $('#chatPanel').empty();
    location.reload()
}

