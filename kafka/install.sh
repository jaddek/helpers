#!/bin/sh
CURRENT_PATH=$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")
DESTINATION_PATH="/local"

DOWNLOAD_SRC="https://dlcdn.apache.org/kafka/3.7.1/kafka_2.13-3.7.1.tgz"
KAFKA_DIR="${DESTINATION_PATH}/kafka/kafka"
DESTINATION_SRC="${DESTINATION_PATH}/kafka/kafka.tgz"

if ! [ -d ${KAFKA_DIR} ]; then
    mkdir -p ${KAFKA_DIR}
fi

if ! [ -f ${DESTINATION_SRC} ]; then
    curl ${DOWNLOAD_SRC} -o ${DESTINATION_SRC}
fi

tar -xvzf ${DESTINATION_SRC} -C ${KAFKA_DIR} --strip 1