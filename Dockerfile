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
#指定工作目录，目录名称自己定义，如果当前指定的目录不存在的话，这个目录会自动被创建
WORKDIR /app

#把当前目录下的所有文件都拷到/app目录下去
COPY ./ ./

# RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt

# 暴露一个80端口
EXPOSE 8080 

# Run the web service on container startup.
CMD ["python", "backend.py"]

