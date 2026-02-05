# 使用官方 Python 3.12 镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制所有文件到容器
COPY . /app

# 使用清华镜像安装依赖（关键！）
RUN pip install --upgrade pip && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ -r requirements.txt

# 收集静态文件
RUN python manage.py collectstatic --noinput

# 暴露端口（Fly.io 默认用 8080）
EXPOSE 8080

# 启动 Gunicorn
CMD ["gunicorn", "ll_project.wsgi", "--bind", "0.0.0.0:8080"]