import json, base64
from tencentcloud.common import credential
from tencentcloud.common.profile.client_profile import ClientProfile
from tencentcloud.common.profile.http_profile import HttpProfile
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.scf.v20180416 import scf_client, models
try:

    zip_file = ""

    with open("./build/deploy.zip", "rb") as f:
        bytes = f.read()
        zip_file = base64.b64encode(bytes).decode('utf-8')

    # 添加腾讯云账户 SecretId 和 SecretKey，此处需注意密钥对的保密，切勿在公开仓库中写明
    cred = credential.Credential("SecretId", "SecretKey")
    httpProfile = HttpProfile()
    httpProfile.endpoint = "scf.tencentcloudapi.com"

    clientProfile = ClientProfile()
    clientProfile.httpProfile = httpProfile
    client = scf_client.ScfClient(cred, "ap-shanghai", clientProfile) # 更改云函数的地域

    req = models.UpdateFunctionCodeRequest()
    params = {
        "FunctionName": "scf-name-", # 更改云函数的名称
        "Code": {
            "ZipFile": zip_file
        },
        "CodeSource": "ZipFile"
    }
    req.from_json_string(json.dumps(params))
    resp = client.UpdateFunctionCode(req)
    print(resp.to_json_string())

except TencentCloudSDKException as err:
    print(err)
