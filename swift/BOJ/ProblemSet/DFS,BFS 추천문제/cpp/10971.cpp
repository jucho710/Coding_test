// https://jdselectron.tistory.com/10

#include <iostream>

using namespace std;

#define MAX 10 // 최대로 주어질 수 있는 도시의 수

int n;
int arr[MAX][MAX];
int visited[MAX];
int minCost = 0;

int user_min(int x, int y) { if (x < y) return x; return y; }

void depth_first_search(int start_node, int row, int sum, int cnt) {
	if (!visited[row]) {
		visited[row] = true;
		for (int col = 0; col < n; col++) {
			if (arr[row][col]) {
				depth_first_search(start_node, col, sum + arr[row][col], cnt + 1);
			}
		}
		visited[row] = false;
	}

	/* n개의 도시를 방문했고(cnt==n), 다시 출발한 도시로 돌아 온 경우(start_node==row)*/
	if (cnt == n && start_node == row) {
		minCost = (minCost == 0) ? sum : user_min(sum, minCost);
	}
}

int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

	/* 입력단 */
	cin >> n;
	for (int row = 0; row < n; row++) {
		for (int col = 0; col < n; col++) {
			cin >> arr[row][col];
		}
	}

	/* 문제풀이 */
	for (int row = 0; row < n; row++) {
		depth_first_search(row,row,0,0);
	}

	/* 출력단 */
	cout << minCost << "\n";

	return 0;
}