# Chapter 04. 구현

# 예제 4-1 상하좌우

n = int(input())
plans = input().split()
result = [1, 1]

for r in plans :
    if r == 'R' :
        if result[1] == n :
            continue
        else :
            result[1] += 1
    elif r == 'L' :
        if result[1] == 1 :
            continue
        else :
            result[1] -= 1
    elif r == 'U' :
        if result[0] == 1 :
            continue
        else :
            result[0] += 1
    else :
        if result[0] == n :
            continue
        else :
            result[0] += 1

print(f'{result[0]} {result[1]}')

# 문제 해설

# L, R, U, D에 따른 이동 방향
dx = [0, 0, -1, 1]
dy = [-1, 1, 0, 0]
move_types = ['L', 'R', 'U', 'D']

# 이동 계획을 하나씩 확인
for plan in plans :
    # 이동 후 좌표 구하기
    for i in range(len(move_types)) :
        if plan == move_types[i] :
            nx = x + dx[i]
            ny = y + dy[i]
    # 공간을 벗어나는 경우 무시
    if nx < 1 or ny < 1 or nx > n or ny > n :
        continue
    # 이동 수행
    x, y = nx, ny

print(x, y) 


# 예제 4-2 시각

n = int(input())
result = 0
Count = 15

# 시각을 고려하지 않은 경우의 수
c = (60-15) * 15 + 15 * 60

if n == 0 :
    result = c
elif n < 3 :
    result = c * (n+1)
elif n < 13 :
    result = c * n + 60*60
elif n < 23 :
    result = c * (n-1) + 60*60*2
else :
    result = c * (n-2) + 60*60*3

print(result)

# 문제 풀이

h = int(input())

count = 0
for i in range(h+1) :
    for j in range(60) :
        for k in range(60) :
            # 매 시각 안에 '3'이 포함되어 있다면 카운트 증가
            if '3' in str(i) + str(j) + str(k) :
                count += 1

print(count)


# 왕실의 나이트

coordinate = input()
x, y = coordinate[0], int(coordinate[1])
result = 0

row = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
collum = [1, 2, 3, 4, 5, 6, 7, 8]

# 각 행동에 따른 좌표 변화
dx = [2, 1]
dy = [1, 2]

for i in range(8) :
    
