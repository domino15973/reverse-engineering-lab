import base64
from Crypto.Cipher import AES

b64_data = ""
key = b""

raw = base64.b64decode(b64_data)

iv = raw[:12]
ciphertext = raw[12:]

cipher = AES.new(key, AES.MODE_GCM, nonce=iv)
plaintext = cipher.decrypt(ciphertext)

print("DECRYPTED:", plaintext.decode("utf-8"))
