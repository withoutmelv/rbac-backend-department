import Router from '@koa/router';
import knowledgeController from '../controllers/knowledge.controller';

const knowledgeRouter = new Router({ prefix: '/sys/knowledge' });

knowledgeRouter.post('/save', knowledgeController.save);
knowledgeRouter.post('/update', knowledgeController.update);
knowledgeRouter.post('/remove', knowledgeController.remove);
knowledgeRouter.post('/detail', knowledgeController.detail);
knowledgeRouter.post('/delete', knowledgeController.delete);
knowledgeRouter.post('/page', knowledgeController.page);

export default knowledgeRouter;