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

    app.io.route('webrtcMsg', app.io.controllers.chat);

};

