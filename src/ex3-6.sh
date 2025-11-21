#!/bin/bash

# 인자 2개 이상 입력
if [ $# -lt 2 ]; then
	echo "사용법: ./ex3-6.sh arg1 arg2 ..."
	exit 1
fi

echo "== 파이썬 파일 실행 =="
./ex3-6.py "$@"
echo "== 파이썬 파일 종료 =="
