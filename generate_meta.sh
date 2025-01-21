#!/bin/bash
# This script will generate a metadata.json file with the current timestamp and a list of all the languages available that pass the validation check

function validate_json {
  jq empty $1 > /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: $1 is not a valid JSON file"
    return 1
  fi

  jq -e 'has("language-name") and has("language-native")' $1 > /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: $1 is missing required fields"
    return 1
  fi

  jq -e '.["language-name"] != "" and .["language-native"] != ""' $1 > /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: $1 has empty language-name or language-native"
    return 1
  fi

  jq -e 'has("language-charset")' $1 > /dev/null
  if [ $? -eq 0 ]; then
    jq -e '.["language-charset"] | match("^(default|greek|korean|japanese|chinese-full|chinese-simplified|cyrillic|thai|vietnamese)$")' $1 > /dev/null
    if [ $? -ne 0 ]; then
      echo "Error: $1 has an invalid language-charset"
      return 1
    fi
  fi

  jq -e 'has("language-fallback")' $1 > /dev/null
  if [ $? -eq 0 ]; then
    fallback=$(jq -r '.["language-fallback"]' $1)
    if [ ! -f translations/$fallback.lang.json ]; then
      echo "Error: $1 has an invalid language-fallback"
      return 1
    fi
  fi

  return 0
}

TARGET_FILE=$1
rm -f $TARGET_FILE

echo -n "{\"timestamp\": $(date +%s), \"languages\": [" > $TARGET_FILE

for file in translations/*.lang.json; do
  validate_json $file
  if [ $? -ne 0 ]; then
    echo "Skipping $file"
    continue
  fi
  echo "Adding $(basename $file .lang.json) to metadata.json"
  echo -n "\"$(basename $file .lang.json)\"," >> $TARGET_FILE
done

sed -i '$ s/.$//' $TARGET_FILE
echo -n "]}" >> $TARGET_FILE