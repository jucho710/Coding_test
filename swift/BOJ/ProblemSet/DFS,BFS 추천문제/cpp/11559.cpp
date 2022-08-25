// https://junseok.tistory.com/137 

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cstdio>
#include <algorithm>
#include <queue>
#include <vector>
#include <stack>
#include <cmath>
#include <cstring>

int chain;
bool get_;
using namespace std;
char puyo[20][7];
int check[13][7];
typedef struct qu {
	int x;
	int y;
}qu;
int arr[4] = { 1,-1,0,0 };
int arr2[4] = { 0,0,1,-1 };
queue<qu> boom;

void down_puyo();

void get_rid() {
	while (!boom.empty()) {
		int x1 = boom.front().x;
		int y1 = boom.front().y;
		boom.pop();
		puyo[x1][y1] = '.';
	}
}
void reset_check() {
	for (int i = 1; i <= 12; i++) {
		for (int j = 1; j <= 6; j++) {
			check[i][j] = 0;
		}
	}
}

void puyo_boom(int a, int b, char c) {
	queue<qu> q;
	q.push({ a,b });
	check[a][b] = 1;
	int cnt = 1;
	while (!q.empty()) {
		int x1 = q.front().x;
		int y1 = q.front().y;
		q.pop();
		for (int i = 0; i < 4; i++) {
			int xx = x1 + arr[i];
			int yy = y1 + arr2[i];
			if (xx >= 1 && yy >= 1 && xx <= 12 && yy <= 6) {
				if (check[xx][yy] == 0 && puyo[xx][yy] == c) {
					cnt++;
					check[xx][yy] = 1;
					q.push({ xx,yy });
					boom.push({ xx,yy });
				}
			}
		}
	}
	//cout << cnt << " ";
	if (cnt < 4) {
		while (!boom.empty()) boom.pop();
	}
	else if (cnt >= 4) {
		get_ = true;
		get_rid();
	}
}

void down_puyo() {
	for (int i = 11; i >= 1; i--) {
		for (int j = 6; j >= 1; j--) {
			if (puyo[i][j] != '.') {
				int x = i;
				int y = j;
				while (1) {
					if (x + 1 <= 12) {
						if (puyo[x + 1][y] == '.') {
							puyo[x + 1][y] = puyo[x][y];
							puyo[x][y] = '.';
							x = x + 1;
						}
						else break;
					}
					else break;

				}
			}
		}
	}

}

void solve() {
	while (1) {
		for (int i = 1; i <= 12; i++) {
			for (int j = 1; j <= 6; j++) {
				if (puyo[i][j] != '.' && check[i][j] == 0) {
					boom.push({ i,j });
					puyo_boom(i, j, puyo[i][j]);
				}
			}
		}
		if (get_ == false) break;
		reset_check();
		down_puyo();
		chain++;
		//cout << chain << "\n";
		get_ = false;
	}
	cout << chain;
}

int main() {
	cin.tie(0);
	cout.tie(0);
	for (int i = 1; i <= 12; i++) {
		for (int j = 1; j <= 6; j++) {
			cin >> puyo[i][j];
		}
	}
	solve();
	return 0;
}