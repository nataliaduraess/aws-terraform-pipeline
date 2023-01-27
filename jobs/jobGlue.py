import sys
from pyspark.context import SparkContext
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import job

#params: ['JOB_NAME']
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


#Ler os dados do IMDB
imdb = (
    spark
    .read
    .format("csv")
    .option("header", True)
    .option("inferSchema", True)
    .option("delimiter", ";")
    .load("s3://data-platform-bronze-prod/raw-database/")  
)    

(
    imdb
    .write
    .mode("overwrite")
    .format("parquet")
    .save("s3://data-platform-silver-prod/parquet-data/")
)