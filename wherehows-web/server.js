'use strict';

const Hapi = require('hapi');

const server = Hapi.server({
    port: 3000,
    host: 'localhost'
});

const init = async () => {

    await server.register(require('inert'));
    await server.register(require('h2o2'));

    await server.register({
        plugin: require('hapi-pino'),
        options: {
            prettyPrint: true,
            logEvents: ['request', 'response']
        }
    });

    server.route({
        method: 'POST',
        path: '/{param}',
        handler: {
            proxy: {
                uri: 'http://localhost:9001{path}'
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/config',
        handler: {
            proxy: {
                uri: 'http://localhost:9001/config'
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/assets',
        handler: {
            proxy: {
                uri: 'http://localhost:9001/assets'
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/{param}',
        handler: {
            directory: {
                path: 'dist',
                index: ['index.html']
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/assets/{param*}',
        handler: {
            directory: {
                path: 'dist/assets',
                index: ['index.html']
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/assets/assets/{param*}',
        handler: {
            directory: {
                path: 'dist/assets',
                index: ['index.html']
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/api/{resource*}',
        handler: {
            proxy: {
                uri: 'http://localhost:9001/{path}'
            }
        }
    });

    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();