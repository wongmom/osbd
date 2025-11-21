#!/bin/bash

# CPU/GPU 상태 확인 함수
check_cpu_gpu() {
    if command -v nvidia-smi &> /dev/null; then
        echo "--- GPU (NVIDIA) 상태 ---"
        nvidia-smi
    else
        echo "--- CPU 사용률 (상위 5개 프로세스) ---"
        top -b -n 1 | head -n 12
        echo ""
    fi
}

# 메뉴 출력 및 선택
echo "=================================="
echo "  리눅스 시스템 상태 확인 메뉴"
echo "=================================="
echo "1) 현재 사용자 정보 및 시스템 정보"
echo "2) CPU 사용률 또는 GPU 상태"
echo "3) 메모리 사용량 (RAM)"
echo "4) 디스크 사용량"
echo "=================================="
echo -n "선택 (1-4): "
read CHOICE

echo ""
case $CHOICE in
    1)
        echo "--- 1. 사용자 정보 및 시스템 정보 ---"
        echo "현재 사용자: $(whoami)"
        echo "로그인 사용자 목록: $(who)"
        echo "시스템 가동 시간: $(uptime)"
        echo "운영체제 정보: $(uname -a)"
        ;;
    2)
        check_cpu_gpu
        ;;
    3)
        echo "--- 3. 메모리 사용량 (RAM) ---"
        free -h
        ;;
    4)
        echo "--- 4. 디스크 사용량 (파일 시스템) ---"
        df -hT
        
        echo ""
        echo "--- 홈 디렉토리 용량 (상위 5개 폴더) ---"
        du -h -d 1 | sort -rh | head -n 5
        ;;
    *)
        echo "❌ 잘못된 선택이거나 종료 옵션이 아닙니다. 스크립트를 종료합니다."
        ;;
esac
echo "" # 실행 결과 구분용 빈 줄
