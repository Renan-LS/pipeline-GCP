from fastapi import FastAPI, HTTPException
import requests
from google.cloud import storage
from pydantic import BaseModel
import uvicorn

app = FastAPI()
#decorator de operação de caminho/rota que se utiliza o caminho ('/')"raiz" e realiza o método GET(lê) o retorno da função descrita abaixo
@app.get('/')
async def read_root():
    return {"Hello": "World"}


#função PARSER para validar os tipos dos dados inseridos nela, no caso URL,BUCKET_NAME e Output_File_Prefix
class Params(BaseModel):
    url: str
    bucket_name: str
    output_file_prefix: str

#funcão responsável por pegar os dados e enviar para o BUCKET do GCS(função disponivel na documentação GCS, no goole)
#recebe como parametros: o bucket pra onde irá enviar o arquivo, o conteúdo desse arquivo , path completo de onde estamos inserindo arquivo no bucket
def put_file_to_gcs(output_file: str, bucket_name: str, content): 
    try:
        storage_client = storage.Client() #inicializa o cliente do GCS
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(output_file)
        blob.upload_from_string(content)

        return 'OK'
    except Exception as ex:
        print(ex)


def get_dados(remote_url): #método que realiza um get nos dados que queremos, no caso, diretamente no link tem-se acesso aos CSV's. 
    response = requests.get(remote_url)

    return response


@app.post("/download_combustivel")
async def download_combustivel(params: Params):
    try:

        data = get_dados(params.url) #passa a url e tem-se os dados, através do método definido acima.

        put_file_to_gcs(bucket_name=params.bucket_name,
                        output_file=params.output_file_prefix,
                        content=data.content)

        return {"Status": "OK", "Bucket_name": params.bucket_name, "url": params.url}
    except Exception as ex:
        raise HTTPException(status_code=ex.code, detail=f"{ex}")


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)