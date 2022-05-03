# Chapter 04. 구현

# 예제 4-1 상하좌우

from msilib import Directory


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

# 문제 해설

# 현재 나이트의 위치 입력받기
coordinate = input()
row = int(coordinate[1])
collumn = int(ord(coordinate[0])) - int(ord('a')) + 1

# 나이트가 이동할 수 있는 8가지 방향 정의
steps = [(-2, -1), (-1, -2), (1, -2), (2, -1), (2, 1), (1, 2), (-1, 2), (-2, 1)]

# 8가지 방향에 대하여 각 위치로 이동이 가능한지 확인
result = 0
for step in steps :
    drow = row + step[0]
    dcollumn = collumn + step[1]
    if drow >= 1 and dcollumn >= 1 and drow <= 8 and dcollumn <= 8 :
        result += 1

print(result)


# 게임 개발

# 문제 해설

n, m = map(int, input().split())

# 방문한 위치를 저장하기 위한 맵을 생성하여 0으로 초기화
d = [[0] * m for _ in range(n)]

x, y, direction = map(int, input().split())
d[x][y] = 1     # 현재 좌표 방문 처리

# 전체 맵 정보를 입력받기
array = []
for i in range(m) :
    array.append(list(map(int, input().split())))

# 북, 동, 남, 서 방향 정의
dx = [-1, 0, 1, 0]
dy = [0, 1, 0, -1]

# 왼쪽으로 회전
def turn_left() :
    global direction
    direction -= 1
    if direction == -1 :
        direction = 3

# 시뮬레이션 시작
count = 1
turn_time = 0
while True :
    # 왼쪽으로 회전
    turn_left()
    nx = x + dx[direction]
    ny = y + dy[direction]
    # 회전한 이후 정면에 가보지 않은 칸이 존재하는 경우 이동
    if d[nx][ny] == 0 and array[nx][ny] == 0 :
        d[nx][ny] = 1
        x = nx
        y = ny
        count += 1
        turn_time = 0
        continue
    # 회전한 이후 정면에 가보지 않은 칸이 없거나 바다인 경우
    else :
        turn_time += 1
    # 네 방향 모두 갈 수 없는 경우
    if turn_time == 4 :
        nx = x - dx[direction]
        ny = y - dy[direction]
        # 뒤로 갈 수 있다면 이동하기
        if array[nx][ny] == 0 :
            x = nx
            y = ny
        # 뒤가 바다로 막혀있는 경우
        else :
            break
        turn_time = 0

print(count)


# 복습

# 예제 4-1 상하좌우

n = int(input())
x, y = 1, 1
plans = list(input().split())

# 각 방향
move_types = ['L', 'R', 'U', 'D']

# 각 방향에 대한 좌표 변화
dx = [0, 0, -1, 1]
dy = [-1, 1, 0, 0]

for plan in plans :
    for i in range(len(move_types)) :
       if plan == move_types[i] :
           nx = x + dx[i]
           ny = y + dy[i]
    if nx < 1 or nx > n or ny < 1 or ny > n :
        continue
    else :
        x = nx
        y = ny

print(x, y)


# 예제 4-2 시각

n = int(input())
result = 0

for i in range(60):
    for j in range(60):
        for k in range(0, n+1) :
            if '3' in str(i) + str(j) + str(k) :
                result += 1

print(result)


# 왕실의 나이트

s = input()

# 좌표로 바꾸기
x = int(s[1])
y = int(ord(s[0])) - int(ord('a')) + 1
count = 0

steps_type = [(-2, -1), (2, -1), (-2, 1), (2, 1), (-1, -2), (1, -2), (-1, 2), (1, 2)]

for step in steps_type :
    nx = x + step[0]
    ny = y + step[1]
    if nx >= 1 and nx <= 8 and ny >= 1 and ny <= 8 :
        count += 1
    
print(count)


# 게임 개발

n, m = map(int, input().split())
x, y, direction = map(int, input().split())

# 방문한 땅을 표시하기 위한 배열 생성
d = [[0] * m for _ in range(n)]     # 리스트 컴프리헨션, 리스트 축약 표현
d[x][y] = 1     # 현재 좌표 방문 처리

# 맵 배열 생성
array = []
for i in range(n) :
    array.append(list(map(int, input().split())))

# 북, 동, 남, 서 정의
dx = [-1, 0, 1, 0]
dy = [0, 1, 0, -1]

# 왼쪽으로 회전
def turn_left():
    global direction    # 전역변수이기에 global 키워드 사용
    direction -= 1
    if direction == -1:
        direction = 3

# 시뮬레이션
turn_time = 0
count = 1
while True:
    turn_left()
    nx = x + dx[direction]
    ny = y + dy[direction]
    # 방문하지 않은 땅의 경우
    if d[nx][ny] == 0 and array[nx][ny] == 0 :
        d[nx][ny] = 1
        x, y = nx, ny
        turn_time = 0
        count += 1
    # 방문한 땅이거나 바다인 경우
    else:
        turn_time += 1
    # 네 방향 모두 불가인 경우
    if turn_time == 4:
        nx = x - dx[direction]
        ny = y - dy[direction]
        # 뒤로 갈 수 있다면 이동
        if array[nx][ny] == 0:
            x, y = nx, ny
        # 뒤가 바다인 경우
        else:
            break
        turn_time = 0

print(count)