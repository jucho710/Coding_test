#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <functional>

using namespace std;


#define MAX 1001
#define INF 987654321

int N, M, X;

vector<pair<int, int>> graph[MAX];


vector<int> dijkstra(int start, int vertex)
{
    vector<int> distance(vertex, INF);
    distance[start] = 0;
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    
    pq.push({0, start});
    while(!pq.empty())
    {
        int cost = pq.top().first;
        int cur = pq.top().second;
        pq.pop();

        if (distance[cur] < cost)   continue;
        for (int i = 0; i < graph[cur].size(); i++){
            int next = graph[cur][i].first;
            int nextCost = graph[cur][i].second + cost;
            if (distance[next] > nextCost){
                distance[next] = nextCost;
                pq.push({nextCost, next});
            }
        }
    }

    return distance;
}




int main()
{
    cin >> N >> M >> X;
    for (int i = 0; i < M; i++){
        int start, end, time;
        cin >> start >> end >> time;
        graph[start].push_back({end, time});
    }

    vector<int> come = dijkstra(X, N + 1);
    
    
    int result = -1;
    for (int i = 1; i <= N; i++){
        vector<int> go = dijkstra(i, N+1);
        if (go[X] + come[i] >= INF || go[X] + come[i] < 0)  continue;
        result = max(result, go[X] + come[i]);
    }
    cout << result << "\n";
    return 0;
}