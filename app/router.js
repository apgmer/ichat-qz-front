'use strict';

module.exports = app => {

    app.get('/', 'home.index');
    app.get('/login', 'home.login');
    app.get('/register', 'home.register');


    app.post('/login', 'home.loginAct');

    app.post('/regcode','home.sendRegCode')
    app.post('/reguser', 'home.registerAct');


    app.get('/logout', 'home.logout');
    app.get('/family','family.showFamilyView')
    app.get('/family/chat','family.showFamilyChatView')

    app.get('/family/delMem','family.delMem')
    app.post('/family/addMem','family.addMem')


    app.get('/keepOnline','home.keepOnline')

    // app.get('/chat', 'chat.showChatView');
    // app.get('/logout', 'home.logout');
    //
    // app.get('/getLoginUser','home.getLoginUser')
    //
    // app.get('/notify', 'chat.showNotifyView');
    //

    //
    // app.get('/friend/search', 'friend.friendSearch');
    // app.get('/friend/addfriendreq', 'friend.addFriendReq'); //发送好友申请请求
    // app.get('/friend/dealNotify', 'friend.dealNotify');
    // app.get('/friend/doneNotify', 'friend.doneNotify');
    //
    app.io.route('webrtcMsg', app.io.controllers.chat);

};

