#!/bin/bash

ENC_BINARY=$1
FOLDER=$2
ENC_DIR_TO_STORE=$3
TMP_PATH=$4
CIPHER_MODE=$5
KEY_PATH=$6

find "$FOLDER" -type f |
  while read file; do
    "$ENC_BINARY" "$file" "" "modify" "$FOLDER" "$ENC_DIR_TO_STORE" "$TMP_PATH" "$CIPHER_MODE" "$KEY_PATH"
  done