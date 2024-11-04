from PIL import Image
import numpy as np

# 创建随机噪声
size = (400, 400)  # 设置合适的尺寸
noise = np.random.normal(128, 40, (size[0], size[1], 3)).astype(np.uint8)

# 创建图片
img = Image.fromarray(noise)
img.save('assets/img/noise.png')