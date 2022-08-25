// https://aeunhi99.tistory.com/59
// 참고: BFS 풀이 - https://velog.io/@matcha_/%EB%B0%B1%EC%A4%80-11724-%EC%97%B0%EA%B2%B0%EC%9A%94%EC%86%8C%EC%9D%98-%EA%B0%9C%EC%88%98-C-BFS-DFS

#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int n, m;
vector<int> adj[1002];
bool visited[1002];
void dfs(int now) {
	visited[now] = 1;
	for (int i = 0; i < adj[now].size(); i++){
		int next = adj[now][i];
		if (!visited[next]) dfs(next);
	}
}


int main() {

	cin >> n >> m;
	for (int i = 0; i < m; i++) {
		int x, y;
		cin >> x >> y;
		adj[x].push_back(y);
		adj[y].push_back(x);
	}
	for (int j = 1; j <= n; j++) {
		sort(adj[j].begin(), adj[j].end());
	}
	
	int cnt = 0;
	for (int k = 1; k <= n; k++) {
		if (visited[k]) continue;
		dfs(k);
		cnt++;
	}
	cout << cnt;
}