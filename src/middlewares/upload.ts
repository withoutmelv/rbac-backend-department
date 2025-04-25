import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { getLoginUserId } from './auth-middleware';

const storage = multer.diskStorage({
    // 存储目录（自动创建）
    destination: (req: any, file: any, cb: any) => {
        const uploadDir ='doc/uploads'; 
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir);
        }
        cb(null, uploadDir);
    },
    // 文件名处理（防重名）
    filename: (req: any, file: any, cb: any) => {
        // const ext = path.extname(file.originalname);\
        console.log(file);
        const type = file.originalname.split('.')[1];
        const filename = getLoginUserId() + '.' + type;
        cb(null, filename);
    }
});

// 3. 创建上传中间件实例
const upload = multer({
    storage,
    // 文件过滤（可选）
    fileFilter: (req: any, file: any, cb: any) => {
        const allowedTypes = ['image/jpeg', 'image/png'];
        if (allowedTypes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('仅支持 JPG/PNG 格式'), false);
        }
    },
    // 文件大小限制（默认无限制）
    limits: { fileSize: 5 * 1024 * 1024 } // 5MB
});

// 问题可能是 upload.single('file') 的类型与 Koa 中间件不兼容，尝试将其包装成 Koa 中间件
export const koaUploadMiddleware = async (ctx: any, next: any) => {
    await new Promise((resolve, reject) => {
        upload.single('file')(ctx.req, ctx.res, (err) => {
            if (err) {
                reject(err);
            } else {
                resolve('Upload successful');
            }
        });
    });
    await next();
};