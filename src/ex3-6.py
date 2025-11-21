#!/usr/bin/env python3

import sys

print("=== Python 실행파일 시작 ===")
print(f"실행 파일 이름 : {sys.argv[0]}")

args = sys.argv[1:]
print(f"입력된 인자 개수: {len(args)}")

for i, a in enumerate(args, start=1):
    print(f"인자 {i}: {a}")

print("=== Python 실행파일 종료 ===")
