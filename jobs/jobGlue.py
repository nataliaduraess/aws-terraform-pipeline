from pyspark.sql import SparkSession

spark = (
    SparkSession.builder.appName("ExerciseSpark")
    .getOrCreate()
)

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