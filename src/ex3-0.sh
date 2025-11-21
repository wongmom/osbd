#!/bin/bash

echo 'ecport MYENV="Hello Shell"' >> ~/.bashrc
source ~/.bashrc

echo "MYENV 변수값 유지 확인: $MYENV"
unset MYENV
echo "환경변수 해제 후 변수값 확인: $MYENV"
