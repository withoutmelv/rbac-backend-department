
import Router from '@koa/router';
import fileInfoController from '../controllers/fileInfo.controller';
import {koaUploadMiddleware} from '../../../middlewares/upload';

const fileInfoRouter = new Router({ prefix: '/sys/fileInfo' });

fileInfoRouter.post('/upload', koaUploadMiddleware, fileInfoController.uploadFile);
export default fileInfoRouter;