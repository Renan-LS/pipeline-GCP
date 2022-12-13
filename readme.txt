google CLOUD
- cria-se uma conta no google console, com 90 dias grátis de utilização 

- cria-se um SERVICE acount para fazer com que o GITHUB tenha interaçãoc om o GCP
 - IAM -> contas de serviço -> "selecionar papel -> editor[maior nivel de privilégio]" 
 - criando chave para autenticação:
  - clica na conta de serviço -> chaves =[json]

- instalar API - Cloud Resource Manager API - necessário quando for utilizar recursos na cloud GCP
- precisamos "setar o projeto". precisei ir no shell do google cloud sdk.
 - "gcloud config set project "nome do projeto"[datapipeline01]
 - "gcloud config list" - verifica se ta autenticado na conta certa e deu certo "setar" o projeto

- agora criar o pipeline público 