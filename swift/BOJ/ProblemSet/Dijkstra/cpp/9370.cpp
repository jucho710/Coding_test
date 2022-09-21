// https://cocoon1787.tistory.com/437

#include<iostream>
#include<algorithm>
#include<vector>
#include<queue>
#include<memory.h>
using namespace std;
#define INF 2100000000 // 21억

int T;
int n, m, t, s, g, h, a, b, d, x;
int scent, crossroad1, crossroad2;
int result_1[50001], result_2[50001];
vector<int> ans;
vector<pair<int, int>> road[50001];

void dijkstra(int start, int* result)
{
	queue<int> q;
	for (int i = 1; i <= n; i++)
		result[i] = INF;

	result[start] = 0;
	q.push(start);

	while (!q.empty())
	{
		int node = q.front();
		int dist = result[node];
		q.pop();

		for (int i = 0; i < road[node].size(); i++)
		{
			int next_node = road[node][i].first;
			int next_dist = road[node][i].second;

			if (result[next_node] > dist + next_dist)
			{
				result[next_node] = dist + next_dist;
				q.push(next_node);
			}
		}
	}
}


int main()
{
	ios_base::sync_with_stdio(0);
	cin.tie();

	cin >> T;

	while (T--)
	{
		// 정답,다익스트라 결과값,교차로 거리정보들 모두 초기화
		ans.clear();
		memset(result_1, 0, sizeof(result_1));
		memset(result_2, 0, sizeof(result_2));
		for (int i = 0; i < 50001; i++)
			road[i].clear();

		cin >> n >> m >> t; // 교차로, 도로, 목적지 수
		cin >> s >> g >> h; // 출발지, 후각1, 후각2

		for (int i = 0; i < m; i++) // 교차로 사이 거리 입력
		{
			cin >> a >> b >> d;

			road[a].push_back({ b,d });
			road[b].push_back({ a,d });

			if ((a == g && b == h) || (a == h && b == g))
				scent = d; // 후각으로 탐지하여 알아낸 교차로 거리
		}
		
		// 출발점에서의 다익스트라
		dijkstra(s, result_1); 

		// 후각으로 탐지한 도로에서의 다익스트라 (더 먼쪽이 가는 길의 방향입니다.)
		if (result_1[g] > result_1[h]) // 출발점 기준으로 crossroad1:가까운 쪽, crossroad2는 먼쪽
		{
			crossroad1 = h;
			crossroad2 = g;
		}
		else
		{
			crossroad1 = g;
			crossroad2 = h;
		}
		dijkstra(crossroad2, result_2);

		for (int i = 0; i < t; i++) // 목적지 후보 검사
		{
			cin >> x;
			// 출발지 ~ 목적지까지의 최단거리 == 출발지 ~ crossroad1 ~ crossroad2 ~ 목적지까지의 최단거리
			if (result_1[x] == result_1[crossroad1] + scent + result_2[x])
				ans.push_back(x);
		}

		sort(ans.begin(), ans.end()); // 정답 오름차순 정렬

		for (int i = 0; i < ans.size(); i++)
			cout << ans[i] << " ";
		cout << '\n';
	}
	
}
