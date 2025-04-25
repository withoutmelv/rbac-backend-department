
class FileInfoService{
    async uploadFile(ctx: any): Promise<any> {
        // 获取上传后的文件信息
        const file = ctx.req.file;
        // 生成文件访问链接（假设服务运行在 3000 端口）
        const fileUrl = `http://${ctx.host}/uploads/${file.filename}`;
        return {
            fullUrl: fileUrl,
            url: `/uploads/${file.filename}`,
            filename: file.filename,
            size: file.size
        }
    }
    
}
export default new FileInfoService();