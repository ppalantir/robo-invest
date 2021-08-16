# -*- coding: utf-8 -*-
import argparse
import base64
import io
import os
import time
import warnings

import numpy as np
from PIL import Image
from flask import Flask, request, jsonify

class FastAiNet:
    def __init__(self, model_path):
        # 模型必须只加载一次，千万不要每次predict加载一次模型
        self.model = None # load_model() 
    
    def predict(self, img):
        # result = self.model.forward() # 你需要写处理函数，然后返回结果
        result = {'bbox':[10,20,80,90]} # 假设你的模型前传以后的运算结果是这样
        return result

app = Flask(__name__)
@app.route('/')
def hello_world():
    return "It''s working"

@app.route('/api', methods=["POST"])
def api_func():
    result_code = None
    result_data = {}

    try:
        response = request.get_json()
        data_str = response['image']
        image_name = response['image_name'] # 也可以在这里获取其他key
        # print(response)
        # 读取图片
        image = base64.b64decode(data_str)
        img = Image.open(io.BytesIO(image))

        if img.mode != 'RGB':
            img = img.convert("RGB")
        # convert to numpy array.
        img_arr = np.array(img)
        result_data['result'] = fastai_net.predict(img)

        result_code = 200
        if False:  # if some condition, 例如非目标物体，例如人脸检测器没有人脸，身份证OCR没有身份证
            result_code = 201
    except IOError:
        # 图片IO出错
        result_code = 202
    except Exception:
        # 识别失败，捕获其他错误
        result_code = 203

    return jsonify({"result_code": result_code, "result_data": result_data})


@app.after_request
def add_headers(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    return response


if __name__ == "__main__":
    # 在这里先实例化预测类，并在类里面加载模型
    # fastai_net = FastAiNet(model_path='/path/to/your/model')
    app.run(debug=True, host="0.0.0.0", port=8080)
