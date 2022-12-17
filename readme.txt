PARTE 1:

google CLOUD
- cria-se uma conta no google console, com 90 dias grátis de utilização 

- cria-se um SERVICE acount para fazer com que o GITHUB tenha interaçãoc om o GCP
 - IAM -> contas de serviço -> "selecionar papel -> editor[maior nivel de privilégio]" 
 - criando chave para autenticação:
  - clica na conta de serviço -> chaves =[json]
  - NAO esquecer de anexar o conteúdo do arquivo JSON ao repositorio de trabalho, através das SETTINGS -> SECRETS -> Actions 
    é através desta ação que o github actions através do terraform consegue acessar o projeto na GCP para criação/alteração de buckets e demais tb_historico_combustivel_brasil 

- instalar API - Cloud Resource Manager API - necessário quando for utilizar recursos na cloud GCP
- precisamos "setar o projeto". precisei ir no shell do google cloud sdk.
 - "gcloud config set project "nome do projeto"[datapipeline01]
 - "gcloud config list" - verifica se ta autenticado na conta certa e deu certo "setar" o projeto

- agora criar o pipeline público:
  - cria-se toda infraestrutura do terraform [main - providers - terraformTVARS - variables] e a esteira WORKFLOW

concluído a parte 1 do projeto, deve-se ter 5 buckets criados na GCP, através do TERRAFORM e GITHUB Actions.

PARTE 2: 

API: 
  - Primeiro cria-se a pasta API -> main.py
  - cria-se um ambiente virtual para instalar as lib's necessarias 
    - pip3 install uvicorn - fastapi - google-cloud-storage - requests - pydantic ()
  - agora, vamos para pasta da api, e da start no servidor "uvicorn main:app"
    - isso é feito após preencher o main.py com um hellow-world para testar se o serviço de API está funcionando
  - código da MAIN comentado para melhor compreensão.
    - nele fica claro a funcionalidade de colher o csv da fonte de dados, e persistir no bucket raw.

  - "pip freeze > requirements.txt" - separa em um arquivo texto tudo que nossa API precisa parar realizar deployment
  - criar um Dockerfile, que vai ser onde a imagem do serviço vai rodar
  - criar um deploy.sh com só isso - "gcloud run deploy pipeline-gcp --source . --region us-central1" 
    - e isto é o que vai deploiar nossa aplicação,  via SDK

PARTE 3: 
  - cria-se um cluster no DATAPROC
    - marca o component gateway ( habilita a web interface do cluster) e habilita o jupyter notebook.
    - na aba Personalisar Cluster -> seleciona la em baixo a Staging á  rea (nosso caso (...)pyspark-tmp2)
    - Vai na pasta LocalDisk, cria uma pasta(datapipeline), e abre um notebook Python3(comb_br)
    - no notebook é desenvolvido o script protótipo para realizar a operação básica de processamento de dados e demais tratamentos,
    ele se encontra na pasta etl-spark, função MAIN.py

PARTE 4:
  - subindo o airflow




