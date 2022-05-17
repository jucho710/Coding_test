graph = []
for i in range(10):
    graph.append(list(map(int, input().split())))


def dfs(x, y):
    nx = x
    ny = y+1
    if graph[nx][ny] == 2:
        return False
    if nx <= -1 or ny <= -1 or nx >= 10 or ny >= 10:
        return False
    if graph[nx][ny] == 1:
        nx = x+1
        ny = y
        dfs(nx, ny)
    if graph[nx][ny] == 0:
        graph[nx][ny] = 9
        dfs(nx, ny)

dfs(1, 1)

for i in range(10):
    for j in range(10):
        print(graph[i][j], end = ' ')
    print()