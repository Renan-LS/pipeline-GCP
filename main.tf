//ESPECIFICA A AÇÃO A SER REALIZADA PELO TERRAFORm
//**PS, TERRAFORM VERIFICA O QUE ESTA SENDO ESPECIFICADO FAZER, SENAO TA DESCRITO, ELE DESTROI O QUE FOI FEITO NA INTERAÇÃO ANTERIOR.
//EX: Em uma interação do terraform, ele cria a table A. Se eu rodar terraform novamente, criando a tabela B e C, e por algum motivo a criação da 
//table A não estiver mais nas ações do TERRAFORM, ele automaticamente DESTROI a table A e cria as B e C.
module "bigquery-dataset-gasolina" {
  source  = "./modules/bigquery"
  dataset_id                  = "gasolina_brasil"
  dataset_name                = "gasolina_brasil"
  description                 = "Dataset a respeito do histórico de preços da Gasolina no Brasil a partir de 2004"
  project_id                  = var.project_id
  location                    = var.region
  delete_contents_on_destroy  = true
  deletion_protection = false
  access = [
    {
      role = "OWNER"
      special_group = "projectOwners"
    },
    {
      role = "READER"
      special_group = "projectReaders"
    },
    {
      role = "WRITER"
      special_group = "projectWriters"
    }
  ]
  tables=[
    {
        table_id           = "tb_historico_combustivel_brasil",
        description        = "Tabela com as informacoes de preço do combustível ao longo dos anos"
        time_partitioning  = {
          type                     = "DAY",
          field                    = "data",
          require_partition_filter = false,
          expiration_ms            = null
        },
        range_partitioning = null,
        expiration_time = null,
        clustering      = ["produto","regiao_sigla", "estado_sigla"],
        labels          = {
          name    = "stack_data_pipeline"
          project  = "gasolina"
        },
        deletion_protection = true
        schema = file("./bigquery/schema/gasolina_brasil/tb_historico_combustivel_brasil.json")
    }
  ]
}

module "bucket-raw" {
  source  = "./modules/gcs"

  name       = "data-pipeline-stack-combustiveis-brasil-raw2"
  project_id = var.project_id
  location   = var.region
}

module "bucket-curated" {
  source  = "./modules/gcs"

  name       = "data-pipeline-stack-combustiveis-brasil-curated2"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-tmp" {
  source  = "./modules/gcs"

  name       = "data-pipeline-stack-combustiveis-brasil-pyspark-tmp2"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-code" {
  source  = "./modules/gcs"

  name       = "data-pipeline-stack-combustiveis-brasil-pyspark-code2"
  project_id = var.project_id
  location   = var.region
}