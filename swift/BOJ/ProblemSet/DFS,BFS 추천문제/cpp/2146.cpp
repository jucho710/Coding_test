// https://velog.io/@e7838752/boj2146

#include <iostream>
#include <algorithm>
#include <queue>
#define INF 987654321

using namespace std;

int n;
int map[100][100];
int dx[] = {0, 1, 0, -1};
int dy[] = {-1, 0, 1, 0};

void dfs(int x, int y, int land) {
  map[x][y] = land;

  for (int i = 0; i < 4; ++i) {
    int nx = x + dx[i];
    int ny = y + dy[i];

    if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
    if (map[nx][ny] == 1) dfs(nx, ny, land);
  }
}

int bfs(int x, int y) {
  int route[100][100] = {0, };
  int land = map[x][y];

  queue<pair<int, int> > q;
  route[x][y] = 1;
  q.push(make_pair(x, y));

  while (!q.empty()) {
    x = q.front().first;
    y = q.front().second;
    q.pop();

    if (land < map[x][y]) return route[x][y] - 2;

    for (int i = 0; i < 4; i++) {
      int nx = x + dx[i];
      int ny = y + dy[i];

      if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
      if (map[nx][ny] == land) continue;
      if (route[nx][ny] > 0) continue;
      
      route[nx][ny] = route[x][y] + 1;
      q.push(make_pair(nx, ny));
    }
  }
  
  return INF;
}

int main() {
  cin.tie(NULL);
  ios_base::sync_with_stdio(false);

  cin >> n;
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      cin >> map[i][j];
    }
  }

  int count = 2;
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      if (map[i][j] == 1) {
        dfs(i, j, count++);
      }
    }
  }

  int answer = INF;
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      if (map[i][j] > 1) {
        answer = min(answer, bfs(i, j));
      }
    }
  }

  cout << answer;
}