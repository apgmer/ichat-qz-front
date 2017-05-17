'use strict';

module.exports = appInfo => {
    const config = {};

    // should change to your own
    config.keys = appInfo.name + '_1493723181148_1490';

    config.view = {
        defaultViewEngine: 'nunjucks',
        mapping: {
            '.tpl': 'nunjucks',
        }
    };

    config.io = {
        init: {},
        namespace: {
            '/': {
                connectionMiddleware: [],
                packetMiddleware: [],
            }
        }
    };



    config.serverUrl = 'http://192.168.1.106:8090/api';

    // config.middleware = ['userAuth'];

    return config;
};

