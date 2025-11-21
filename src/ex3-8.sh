#!/bin/bash

DB_DIR="DB"
TRAIN_DIR="train"
ARCHIVE_NAME="archive.tar.gz"
NUM_FILES=5

echo "### 셸 스크립트 시작: ex3-8.sh ###"
echo "-----------------------------------"

# 1. 'DB' 폴더가 있는지 확인하고 없다면 생성
if [ ! -d "$DB_DIR" ]; then
    echo "1. '$DB_DIR' 폴더가 없어 생성합니다."
    mkdir "$DB_DIR"
else
    echo "1. '$DB_DIR' 폴더가 이미 존재합니다."
fi

# 'DB' 폴더로 이동
cd "$DB_DIR"

# 2. 임의의 5개 파일 생성
echo "2. 임의의 ${NUM_FILES}개 파일을 생성합니다."
for i in $(seq 1 $NUM_FILES); do
    FILE_NAME="data_$(printf "%02d" $i).txt"
    echo "This is file number $i." > "$FILE_NAME"
    echo "  -> $FILE_NAME 생성 완료"
done

# 3. 생성된 파일들을 압축 (tar.gz)
echo "3. 생성된 파일들을 '$ARCHIVE_NAME'으로 압축합니다."
# c: 생성, v: 상세 출력, f: 파일 이름 지정, z: gzip 압축 사용
tar -czf "$ARCHIVE_NAME" *.txt
echo "  -> 압축 파일 생성 완료."

# 'DB' 폴더에서 상위 경로로 이동
cd ..

# 4. 'train' 폴더 생성
if [ ! -d "$TRAIN_DIR" ]; then
    echo "4. '$TRAIN_DIR' 폴더를 생성합니다."
    mkdir "$TRAIN_DIR"
else
    echo "4. '$TRAIN_DIR' 폴더가 이미 존재합니다."
fi

# 5. DB 폴더의 파일 5개에 대한 링크 생성
echo "5. '$DB_DIR' 폴더의 파일에 대한 소프트 링크를 '$TRAIN_DIR'에 생성합니다."
for i in $(seq 1 $NUM_FILES); do
    SOURCE_FILE="$DB_DIR/data_$(printf "%02d" $i).txt"
    LINK_NAME="$TRAIN_DIR/link_$(printf "%02d" $i).txt"
    
    # ln -s: 소프트 링크(심볼릭 링크) 생성
    ln -s "$SOURCE_FILE" "$LINK_NAME"
    echo "  -> $LINK_NAME 생성 완료"
done

echo "-----------------------------------"
echo "### 셸 스크립트 종료: ex3-8.sh ###"
