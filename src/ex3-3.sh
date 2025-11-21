#!/bin/bash

get_grade() {
    SCORE=$1
    if [ $SCORE -ge 90 ]; then
        echo "A"
    else
        echo "B"
    fi
}

echo "점수들을 입력하세요 (예: 95 88 100): "
read -a SCORES

if [ ${#SCORES[@]} -lt 2 ]; then
    echo "오류: 최소한 두 개 이상의 점수를 입력해야 합니다."
    exit 1
fi

TOTAL_SUM=0
COUNT=0

echo "------------------------"
echo "점수 | 등급"
echo "------------------------"

for score in "${SCORES[@]}"; do
    if [ "$score" -lt 0 ] || [ "$score" -gt 100 ]; then
        continue
    fi
    
    GRADE=$(get_grade "$score")
    printf " %-4s | %s\n" "$score" "$GRADE"
    
    TOTAL_SUM=$((TOTAL_SUM + score))
    COUNT=$((COUNT + 1))
done

if [ $COUNT -eq 0 ]; then
    echo "유효한 점수가 없습니다."
    exit 0
fi

AVERAGE=$(($TOTAL_SUM / $COUNT))
AVG_GRADE=$(get_grade "$AVERAGE")

echo "------------------------"
echo "평균 점수: $AVERAGE"
echo "평균 등급: $AVG_GRADE"
echo "------------------------"
