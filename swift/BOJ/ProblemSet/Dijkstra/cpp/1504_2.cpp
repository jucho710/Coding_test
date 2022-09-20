#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
#include <functional>

using namespace std;

int N, E;
const int MAX = 800 + 1;
const int INF = 200000000;

vector<pair<int, int>> graph[MAX];
int trace[MAX];


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

        for (int i = 0; i < graph[cur].size();  i++)
        {
            int neighbor = graph[cur][i].first;
            int neighborDistance = cost + graph[cur][i].second;

            if (distance[neighbor] > neighborDistance)
            {
                distance[neighbor] = neighborDistance;
                trace[neighbor] = cur;
                pq.push({neighborDistance, neighbor});

            }
        }
    }
    return distance;
}


int main()
{
    ios_base::sync_with_stdio(false);   cin.tie(NULL);  cout.tie(NULL);

    cin >> N >> E;
    for (int i = 0; i < E; i++){
        int a, b, c;
        cin >> a >> b >> c;
        graph[a].push_back(make_pair(b, c));
        graph[b].push_back(make_pair(a, c));
    }

    int v1, v2;
    cin >> v1 >> v2;

    vector<int> temp = dijkstra(1, N+1);
    vector<int> temp2 = dijkstra(v1, N+1);
    vector<int> temp3 = dijkstra(v2, N+1);

    int result = min(temp[v1] + temp2[v2] + temp3[N], temp[v2] + temp3[v1] + temp2[N]);
    if (result >= INF || result < 0)    result = -1;
    cout << result << "\n";

    return 0;
}