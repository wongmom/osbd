#!/bin/bash

# 인자가 2개인지 확인
if [ $# -ne 2 ]; then
    echo "사용법: $0 num1 num2"
    exit 1
fi

a="$1"
b="$2"

echo "입력 값: a = $a, b = $b"
echo "--------------------------"

echo "a + b = $((a + b))"
echo "a - b = $((a - b))"
echo "a * b = $((a * b))"
# 나눗셈은 0 나누기 체크
if [ $b -ne 0 ]; then
    echo "a / b = $((a / b))"
else
    echo "a / b = 계산 불가 (0으로 나눌 수 없음)"
fi
