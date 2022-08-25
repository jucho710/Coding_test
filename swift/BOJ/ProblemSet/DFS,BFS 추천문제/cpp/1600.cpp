// https://ongveloper.tistory.com/177

#include <iostream>
#include <algorithm>
#include <queue>

#define MAX (201)
using namespace std;
int W, H, K;
int dir[4][2] = { {0,1},{1,0},{0,-1},{-1,0} };
int jumpDir[8][2] = { {-1,-2},{-1,2},{1,-2},{1,2},{-2,-1},{-2,1},{2,-1},{2,1} };
bool visited[MAX][MAX][31];
char graph[MAX][MAX];

void bfs() {

	//r,c,k  k는 점프가능횟수
	queue<pair<pair<int,int>,pair<int,int>>> q;
	q.push({ {0,0},{0,K} });
	visited[0][0][K] = true;
	while (!q.empty()) {
		int r = q.front().first.first;
		int c = q.front().first.second;
		int cnt = q.front().second.first;
		int k = q.front().second.second;
		
		q.pop();
		if (r == H - 1 && c == W - 1) {
			cout << cnt;
			return;
		}

		if (k > 0) {
			for (int i = 0; i < 8; i++) {
				int nr = r + jumpDir[i][0];
				int nc = c + jumpDir[i][1];
				if (nr >= 0 && nr < H && nc >= 0 && nc < W && graph[nr][nc] == '0') {
					if (!visited[nr][nc][k - 1]) {
						q.push({ {nr,nc}, {cnt + 1,k - 1} });
						visited[nr][nc][k - 1] =true;
					}
				}
			}
		}
		for (int i = 0; i < 4; i++) {
			int nr = r + dir[i][0];
			int nc = c + dir[i][1];
			if (nr >= 0 && nr < H && nc >= 0 && nc < W && graph[nr][nc] == '0') {
				if (!visited[nr][nc][k]) {
					q.push({ {nr,nc},{cnt + 1, k} });
					visited[nr][nc][k] = true;
				}
			}
		}
	}
	cout << -1;

}

int main() {
	ios::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);

	cin >> K >> W >> H;

	for (int i = 0; i < H; i++) {
		for (int j = 0; j < W; j++) {
			cin >> graph[i][j];
		}
	}
	bfs();

	return 0;
}