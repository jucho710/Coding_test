// https://nim-code.tistory.com/259

#include <iostream>
#include <queue>
#include <cstring>//memset
using namespace std;

struct Pos {
	int x, y;
};

int n, m;
int Map[50][50];
bool visited[50][50];
const int dx[] = { 0,-1,0,1 };//서, 북, 동, 남
const int dy[] = { -1,0,1,0 };//1,2,4,8 순서!

int bfs(int startx, int starty) {
	int room_size = 1;
	queue<Pos>q;
	q.push({ startx,starty });
	visited[startx][starty] = true;
	while (!q.empty()) {
		int x = q.front().x;
		int y = q.front().y;
		q.pop();
		int wall = 1;
		for (int i = 0; i < 4; i++) {
			//해당 방향에 벽이 없으면
			if ((Map[x][y] & wall) != wall) {
				int nx = x + dx[i];
				int ny = y + dy[i];
				if (nx < 0 || nx >= m || ny < 0 || ny >= n)
					continue;
				if (visited[nx][ny] == false) {
					visited[nx][ny] = true;
					q.push({ nx,ny });
					room_size++;
				}
			}
			wall = wall * 2;
		}
	}
	return room_size;
}

int main() {
	cin >> n >> m;
	int room_cnt = 0;
	int largest_room = -1;
	int largest_room2 = -1;
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
			cin >> Map[i][j];
		}
	}
	//방의 개수와 가장 넓은 방의 넓이 구하기
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
			if (visited[i][j] == false) {
				int room_size = bfs(i, j);
				if (largest_room < room_size)
					largest_room = room_size;
				room_cnt++;
			}
		}
	}
	
	//하나의 벽 제거하여 얻을 수 있는 가장 넓은 방의 크기 구하기
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
			for (int wall = 1; wall <= 8; wall *= 2) {
				if ((Map[i][j] & wall) == wall) {
					memset(visited, false, sizeof(visited));
					Map[i][j] -= wall;
					int room_size = bfs(i, j);
					if (largest_room2 < room_size)
						largest_room2 = room_size;
					Map[i][j] += wall;
				}
			}
		}
	}
	cout << room_cnt << '\n' << largest_room << '\n' << largest_room2 << '\n';
	return 0;
}