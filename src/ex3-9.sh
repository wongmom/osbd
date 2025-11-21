#!/bin/bash

DB_FILE="DB.txt"

# 파일이 없으면 헤더와 함께 생성
if [ ! -f "$DB_FILE" ]; then
    echo "TYPE|DATA1|DATA2|MEMO" > "$DB_FILE"
fi

# 메뉴 출력 함수
print_menu() {
    echo "==================================="
    echo "팀원 및 활동 기록 관리 시스템"
    echo "==================================="
    echo "1) 팀원 정보 추가 (이름, 생일/전화번호)"
    echo "2) 팀원과 한 일 기록 (날짜, 이름, 내용)"
    echo "3) 팀원 이름으로 검색"
    echo "4) 날짜로 수행 내용 검색"
    echo "5) 종료"
    echo "==================================="
    echo -n "선택 (1-5): "
}

# 1. 팀원 정보 추가
add_member() {
    echo ""
    echo "--- 1. 팀원 정보 추가 ---"
    echo -n "이름: "
    read NAME
    echo -n "생일 (YYYYMMDD) 또는 전화번호: "
    read CONTACT

    # TYPE|DATA1|DATA2|MEMO 형식으로 저장 (MEMBER|이름|연락처|)
    echo "MEMBER|$NAME|$CONTACT|" >> "$DB_FILE"
    echo "✅ 팀원 정보가 '$DB_FILE'에 추가되었습니다."
}

# 2. 팀원과 한 일 기록
add_activity() {
    echo ""
    echo "--- 2. 팀원과 한 일 기록 ---"
    echo -n "날짜 (YYYYMMDD): "
    read DATE
    echo -n "함께한 팀원 이름: "
    read TEAMMATE
    echo -n "토의/수행 내용: "
    read MEMO
    
    # TYPE|DATA1|DATA2|MEMO 형식으로 저장 (ACTIVITY|날짜|이름|내용)
    echo "ACTIVITY|$DATE|$TEAMMATE|$MEMO" >> "$DB_FILE"
    echo "✅ 활동 기록이 '$DB_FILE'에 추가되었습니다."
}

# 3. 팀원 이름으로 검색
search_member() {
    echo ""
    echo "--- 3. 팀원 이름으로 검색 ---"
    echo -n "검색할 팀원 이름: "
    read SEARCH_NAME
    
    # MEMBER 타입 항목 중 입력된 이름이 포함된 라인 검색
    echo "--- 검색 결과 (팀원 정보) ---"
    # '^MEMBER'로 시작하는 줄에서 $SEARCH_NAME이 포함된 항목을 찾음
    grep "^MEMBER.*$SEARCH_NAME" "$DB_FILE" | column -t -s '|'
    
    if [ $? -ne 0 ]; then
        echo "검색된 팀원 정보가 없습니다."
    fi
}

# 4. 날짜로 수행 내용 검색
search_activity() {
    echo ""
    echo "--- 4. 날짜로 수행 내용 검색 ---"
    echo -n "검색할 날짜 (YYYYMMDD): "
    read SEARCH_DATE
    
    # ACTIVITY 타입 항목 중 입력된 날짜가 포함된 라인 검색
    echo "--- 검색 결과 (날짜별 활동 기록) ---"
    # '^ACTIVITY'로 시작하고 $SEARCH_DATE를 포함하는 줄을 찾음
    grep "^ACTIVITY.*$SEARCH_DATE" "$DB_FILE" | column -t -s '|'
    
    if [ $? -ne 0 ]; then
        echo "검색된 활동 기록이 없습니다."
    fi
}

# 메인 루프 시작
while true; do
    print_menu
    read CHOICE

    case $CHOICE in
        1)
            add_member
            ;;
        2)
            add_activity
            ;;
        3)
            search_member
            ;;
        4)
            search_activity
            ;;
        5)
            echo "프로그램을 종료합니다."
            exit 0
            ;;
        *)
            echo "❌ 잘못된 선택입니다. 1에서 5 사이의 숫자를 입력해주세요."
            ;;
    esac
    echo ""
done
