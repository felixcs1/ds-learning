from pyspark import SparkConf, SparkContext

conf = SparkConf().setAppName("Read file")

sc = SparkContext.getOrCreate(conf=conf)

text = sc.textFile("data/example_rdd_file.txt")

print(text.collect())