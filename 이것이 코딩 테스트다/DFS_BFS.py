# Chapter 05. DFS/BFS

# 팩토리얼 예제

def factorial_func(n) :
    if n <= 1:
        return 1
    return n * factorial_func(n-1)

print(factorial_func(5))


# DFS 예제

# DFS 메소드 정의
def dfs(graph, v, visited):
    # 현재 노드를 방문 처리
    visited[v] = True
    print(v, end = ' ')
    # 현재 노드와 연결된 다른 노드를 재귀적으로 방문
    for i in graph[v]:
        if not visited[i]:
            dfs(graph, i, visited)

# 각 노드가 연결된 정보를 리스트 자료형으로 표현(2차원 리스트)
graph = [
    [],
    [2, 3, 8],
    [1, 7],
    [1, 4, 5],
    [3, 5],
    [3, 4],
    [7],
    [2, 6, 8],
    [1, 7]
]

# 각 노드가 방문된 정보를 리스트 자료형으로 표현(1차원 리스트)
visited = [False] * 9

dfs(graph, 1, visited)


# BFS 예제

from collections import deque
import imp
from tkinter.tix import Tree
from xmlrpc.client import Boolean

# BFS 정의
def bfs(graph, start, visited):
    # 큐(Queue) 구현을 위해 deque 라이브러리 사용
    queue = deque([start])
    # 현재 노드를 방문 처리
    visited[start] = True
    # 큐가 빌 때까지 반복
    while queue:
        # 큐에서 하나의 원소를 뽑아 출력
        v = queue.popleft()
        print(v, end = ' ')
        # 해당 원소와 연결된, 아직 방문하지 않은 원소들을 큐에 삽입
        for i in graph[v]:
            if not visited[i]:
                queue.append(i)
                visited[i] = True

# 각 노드가 연결된 정보를 리스트 자료형으로 표현(2차원 리스트)
graph = [
    [],
    [2, 3, 8],
    [1, 7],
    [1, 4, 5],
    [3, 5],
    [3, 4],
    [7],
    [2, 6, 8],
    [1, 7]
]

# 각 노드가 방문된 정보를 리스트 자료형으로 표현(1차원 리스트)
visited = [False] * 9

bfs(graph, 1, visited)


# 실전문제

# 3 음료수 얼려 먹기

# 오답
# n, m = map(int, input().split())
# count = 0

# def dfs(graph, x, y, visited):
#     visited[x][y] = True
#     for i in graph[x]:
#         if not visited[x][i]:
#             visited[x][i] = True
#             dfs[graph, x, i, visited]
#             count += 1
        
# graph = []

# dx = [-1, 1, 0, 0]
# dy = [0, 0, -1, 1]
# x, y = 0, 0
# glist = []

# for i in range(n):
#     for j in range(len(dx)):
#         nx = x + dx[j]
#         ny = y + dy[j]
#         if nx >= 0 and ny >= 0 and nx < m and ny < n:
#             x, y = nx, ny
#             glist.append([x, y])
#         graph.append(glist)

# visited = []
# for i in range(n):
#     lst = list(str(input()))
#     for j in range(m):
#         if j == '0':
#             j = False
#         else:
#             j = True
#     visited.append(lst)

# dfs(graph, 0, 0, visited)

# 문제 해설

# 1. 특정한 지점의 주변 상, 하, 좌, 우를 살펴본 뒤에 주변 지점 중에서 값이 '0'이면서 아직 방문하지 않은 지점이 있다면 해당 지점 방문
# 2. 방문한 지점에서 다시 상, 하, 좌, 우를 살펴보면서 방문을 다시 진행하면, 연결된 모든 지점 방문 가능
# 3. 1~2번의 과정을 모든 노드에 반복하며 방문하지 않은 지점의 수를 셈

n, m = map(int, input().split())

graph = []
for i in range(n):
    graph.append(list(map(int, input())))

# DFS로 특정한 노드를 방문한 뒤에 연결된 모든 노드들도 방문
def dfs(x, y):
    # 주어진 범위를 벗어나는 경우에는 즉시 종료
    if x <= -1 or x >= n or y <= -1 or y >= m :
        return False
    # 현재 노드를 아직 방문하지 않았다면
    if graph[x][y] == 0:
        # 해당 노드 방문 처리
        graph[x][y] = 1
        # 상, 하, 좌, 우의 위치도 모두 재귀적으로 호출
        dfs(x-1, y)
        dfs(x, y-1)
        dfs(x+1, y)
        dfs(x, y+1)
        return True
    return False

# 모든 노드(위치)에 대하여 음료수 채우기
result = 0
for i in range(n):
    for j in range(m):
        # 현재 위치에서 DFS 수행
        if dfs(i, j) == True:
            result += 1

print(result)


n, m = map(int, input().split())

# graph 받기
graph = []
for i in range(n):
    graph.append(list(map(int, input())))

def dfs(x, y):
    # 주어진 범위 벗어나면 즉시 종료
    if x <= -1 or y <= -1 or x >= n or y >= m:
        return False
    # 방문하지 않은 노드라면
    if graph[x][y] == 0:
        # 방문처리
        graph[x][y] = 1
        # 상, 하, 좌, 우에 재귀적으로 호출
        dfs(x-1, y)
        dfs(x+1, y)
        dfs(x, y-1)
        dfs(x, y+1)
        return True
    return False

result = 0
for i in range(n):
    for j in range(m):
        if dfs(i, j) == True:
            result += 1

print(result)


# 미로 탈출

# 오답

# 1, 1 방문처리, 큐에 넣기
# 1, 1 큐에서 빼고 그 주변 방문, 방문하지 않은 노드 큐에 넣고 방문처리
# 큐에서 하나 빼고 그 주변 방문하지 않은 노드 큐에 넣고 방문 처리
# 반복하다가 뺀 큐가 n, m 이면 종료
# 넣는 우선순위는 x 기준, 넣을 때 카운트

# from collections import deque

# n, m = map(int, input().split())

# graph = []
# for i in range(n):
#     graph.append(list(map(int, input())))

# dx = [1, 0, -1, 0]
# dy = [0, 1, 0, -1]

# count = 0

# def bfs(x, y):
#     x, y = x-1, y-1
#     global count
#     queue = deque([])
#     queue.append([x, y])
#     graph[x][y] = 0
#     # n, m에 도달할 때까지
#     while queue:
#         lst = queue.popleft()
#         print(lst)
#         for i in range(len(dx)):
#             nx = lst[0] + dx[i]
#             ny = lst[1] + dy[i]
#             if nx >= 0 and ny >= 0 and nx < n and ny < m:
#                 if graph[nx][ny] == 1:
#                     graph[nx][ny] = 0
#                     queue.append([nx, ny])
#                     count += 1
            
# bfs(1, 1)
# print(count)


# 문제 해설

from collections import deque

n, m = map(int, input().split())

graph = []
for i in range(n):
    graph.append(list(map(int, input())))

# 이동할 네 방향 정의(상, 하, 좌, 우)
dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]

def bfs(x, y):
    queue = deque()
    queue.append((x, y))
    while queue:
        x, y = queue.popleft()
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]
            # 미로 찾기 공간을 벗어난 경우 무시
            if nx < 0 or ny < 0 or nx >= n or ny >= m:
                continue
            # 벽인 경우 무시
            if graph[nx][ny] == 0:
                continue
            # 해당 노드를 처음 방문하는 경우에만 최단 거리 기록
            if graph[nx][ny] == 1:
                graph[nx][ny] = graph[x][y] + 1
                queue.append((nx, ny))
    # 가장 오른쪽 아래까지의 최단 거리 변환
    return graph[n-1][m-1]

print(bfs(0, 0))


from collections import deque

n, m = map(int, input().split())
graph = []
for i in range(n):
    graph.append(list(map(int, input())))

# 상하좌우 정의
dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]

def bfs(x, y):
    queue = deque()
    queue.append((x, y))
    while queue:
        x, y = queue.popleft()
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]
            # 미로 벗어난 경우 무시
            if nx < 0 or ny < 0 or nx >= n or ny >= m:
                continue
            # 벽인 경우 무시
            if graph[nx][ny] == 0:
                continue
            # 방문하지 않은 길이면 큐에 넣고 최단 거리 기록
            if graph[nx][ny] == 1:
                graph[nx][ny] = graph[x][y] + 1
                queue.append((nx, ny))
    return graph[n-1][m-1]

print(bfs(0, 0))


# 복습

# 음료수 얼려 먹기

n, m = map(int, input().split())
graph = []
for i in range(n):
    graph.append(list(map(int, input())))

def dfs(x, y):
    # 좌표 넘어가면 탈락
    if x <= -1 or y <= -1 or x >= n or y >= m:
        return False
    if graph[x][y] == 0:
        graph[x][y] = 1
        dfs(x-1, y)
        dfs(x+1, y)
        dfs(x, y-1)
        dfs(x, y+1)
        return True
    return False

result = 0

for i in range(n):
    for j in range(m):
        if dfs(i, j) == True:
            result += 1

print(result)


# 미로 탈출

from collections import deque

n, m = map(int, input().split())
graph = []
for i in range(n):
    graph.append(list(map(int, input())))

# 상하좌우 정의
dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]

def bfs(x, y):
    queue = deque()
    queue.append((x, y))
    while queue:
        x, y = queue.popleft()
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]
            # 범위 넘어가면 탈락
            if nx < 0 or ny < 0 or nx >= n or ny >= m:
                continue
            # 벽이어도 탈락 
            if graph[nx][ny] == 0:
                continue
            # 안 가본 곳이면 더하기
            if graph[nx][ny] == 1:
                graph[nx][ny] = graph[x][y] + 1
                queue.append((nx, ny))
    return graph[n-1][m-1]

print(bfs(0, 0))