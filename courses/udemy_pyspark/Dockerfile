ARG IMAGE_VARIANT=slim-buster
ARG OPENJDK_VERSION=8
ARG PYTHON_VERSION=3.8.5

FROM python:${PYTHON_VERSION}-${IMAGE_VARIANT} AS py3
FROM openjdk:${OPENJDK_VERSION}-${IMAGE_VARIANT}

COPY --from=py3 / /

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://jdbc.postgresql.org/download/postgresql-42.7.0.jar
# RUN mv postgresql-42.7.0.jar /opt/spark/jars


ARG PYSPARK_VERSION=3.5.0

RUN pip --no-cache-dir install pyspark==${PYSPARK_VERSION}
RUN pip --no-cache-dir install pandas
RUN pip --no-cache-dir install ipykernel
RUN pip --no-cache-dir install boto3

ENTRYPOINT ["bash"]