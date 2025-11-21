#!/bin/bash

# 성적을 저장할 전역 배열
SCORES=()
# 평균 등급(GPA) 계산을 위한 함수 (예시 구현)
gpa_convert() {
    local avg_score=$1
    if [ "$avg_score" -ge 90 ]; then
        echo "A"
    elif [ "$avg_score" -ge 80 ]; then
        echo "B"
    elif [ "$avg_score" -ge 70 ]; then
        echo "C"
    else
        echo "D"
    fi
}

# 메뉴 출력 함수
print_menu() {
    echo "=============================="
    echo "1) 과목 성적 추가"
    echo "2) 입력된 모든 점수 보기"
    echo "3) 평균 점수 확인"
    echo "4) 평균 등급(GPA) 변환"
    echo "5) 종료"
    echo "=============================="
    echo -n "선택 (1-5): "
}

# 메인 루프 시작
while true; do
    print_menu
    read CHOICE

    case $CHOICE in
        1)
            echo ""
            echo "--- 1. 과목 성적 추가 ---"
            echo -n "추가할 점수를 입력하세요 (0~100): "
            read NEW_SCORE
            
            # 숫자 및 범위 유효성 검사 (간단화)
            if [[ "$NEW_SCORE" =~ ^[0-9]+$ ]] && [ "$NEW_SCORE" -ge 0 ] && [ "$NEW_SCORE" -le 100 ]; then
                SCORES+=("$NEW_SCORE")
                echo "✅ $NEW_SCORE 점수가 추가되었습니다."
            else
                echo "❌ 유효하지 않은 점수입니다. (0~100 범위의 정수만 가능)"
            fi
            ;;
        2)
            echo ""
            echo "--- 2. 입력된 모든 점수 보기 ---"
            if [ ${#SCORES[@]} -eq 0 ]; then
                echo "입력된 점수가 없습니다."
            else
                echo "총 ${#SCORES[@]} 개의 점수가 입력되었습니다: ${SCORES[@]}"
            fi
            ;;
        3)
            echo ""
            echo "--- 3. 평균 점수 확인 ---"
            if [ ${#SCORES[@]} -eq 0 ]; then
                echo "점수가 없어 평균을 계산할 수 없습니다."
            else
                TOTAL_SUM=0
                for score in "${SCORES[@]}"; do
                    TOTAL_SUM=$((TOTAL_SUM + score))
                done
                
                COUNT=${#SCORES[@]}
                AVERAGE=$(($TOTAL_SUM / $COUNT))
                
                echo "총합: $TOTAL_SUM, 과목 수: $COUNT"
                echo "평균 점수: $AVERAGE (정수 나눗셈)"
            fi
            ;;
        4)
            echo ""
            echo "--- 4. 평균 등급(GPA) 변환 ---"
            if [ ${#SCORES[@]} -eq 0 ]; then
                echo "점수가 없어 등급을 계산할 수 없습니다."
            else
                TOTAL_SUM=0
                for score in "${SCORES[@]}"; do
                    TOTAL_SUM=$((TOTAL_SUM + score))
                done
                
                COUNT=${#SCORES[@]}
                AVERAGE=$(($TOTAL_SUM / $COUNT))
                AVG_GPA=$(gpa_convert "$AVERAGE")
                
                echo "평균 점수 ($AVERAGE)의 GPA 등급: $AVG_GPA"
            fi
            ;;
        5)
            echo "프로그램을 종료합니다. 감사합니다."
            exit 0
            ;;
        *)
            echo "❌ 잘못된 선택입니다. 1에서 5 사이의 숫자를 입력해주세요."
            ;;
    esac
    echo "" # 메뉴 구분용 빈 줄
done
