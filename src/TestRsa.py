#!/usr/bin/env python
# -*- coding:utf-8 -*-
import rsa
import binascii

# 使用网页中获得的n和e值，将明文加密
def rsa_encrypt(rsa_n, rsa_e, message):
    # 用n值和e值生成公钥
    key = rsa.PublicKey(rsa_n, rsa_e)
    # 用公钥把明文加密
    message = rsa.encrypt(message.encode(), key)
    # 转化成常用的可读性高的十六进制
    message = binascii.b2a_hex(message)
    # 将加密结果转化回字符串并返回
    return message.decode()

# RSA的公钥有两个值n和e，在网站中获得的公钥一般就是这样的两个值。
# n常常为长度为256的十六进制字符串
# e常常为十六进制‘10001’
pubkey_n = '8d7e6949d411ce14d7d233d7160f5b2cc753930caba4d5ad24f923a505253b9c39b09a059732250e56c594d735077cfcb0c3508e9f544f101bdf7e97fe1b0d97f273468264b8b24caaa2a90cd9708a417c51cf8ba35444d37c514a0490441a773ccb121034f29748763c6c4f76eb0303559c57071fd89234d140c8bb965f9725'
pubkey_e = '10001'
# 需要将十六进制转换成十进制
rsa_n = int(pubkey_n, 16)
rsa_e = int(pubkey_e, 16)
# 要加密的明文
message = '很厉害的文字'

print("公钥n值长度：", len(pubkey_n))
print(rsa_encrypt(rsa_n, rsa_e, message))