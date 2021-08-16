# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
#基础镜像
FROM python:3.7

# RUN apt-get update && \
#     apt-get install -y python3 \
#                         python3-dev \
#                         python3-pip \
#     && apt-get clean \
#     && apt-get autoclean \
#     && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
#进入目录后切换到/app目录下
WORKDIR /app

#把当前目录下的所有文件都拷到/app目录下去
COPY scr .
COPY requirements.txt .

# RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir -r requirements.txt
RUN pip3 install -r requirements.txt

# 暴露一个80端口
EXPOSE 8080 

# Run the web service on container startup.
CMD python /app/src/backend.py

