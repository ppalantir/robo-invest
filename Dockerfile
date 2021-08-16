# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
#基础镜像
FROM boystar/ubantu:latest

RUN mkdir -p /app
#进入目录后切换到/app目录下
WORKDIR /app

#把当前目录下的所有文件都拷到/app目录下去
ADD . /app
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

# 暴露一个80端口
EXPOSE 8080 

# Run the web service on container startup.
CMD ["python3" "src/backend.py"]

