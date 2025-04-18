import Router from '@koa/router';
import roleKnowledgeController from '../controllers/role-knowledge.controller';

const router = new Router({ prefix: '/sys/role-knowledge' });

router.post('/create', roleKnowledgeController.create);
router.get('/delete/:roleId', roleKnowledgeController.removeByRoleId);

router.post('/update', roleKnowledgeController.update);
router.get('/role/:roleId', roleKnowledgeController.findByRoleId);
router.get('/knowledge/:knowledgeId', roleKnowledgeController.findByKnowledgeId);

export default router;