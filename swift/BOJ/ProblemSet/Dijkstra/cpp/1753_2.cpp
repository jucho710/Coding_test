

#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <functional>

using namespace std;


int V, E, K;
const int MAX = 20000 + 1;
const int INF = 3000000;

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
        for (int i = 0; i < graph[cur].size(); i++)
        {
            int neighbor = graph[cur][i].first;
            int neighborDistance = cost + graph[cur][i].second;

            if (distance[neighbor] > neighborDistance){
                distance[neighbor] = neighborDistance;
                pq.push({neighborDistance, neighbor});
            }
        }
    }
    

    return distance;
}



int main()
{
    ios_base::sync_with_stdio(false);   cin.tie(NULL);  cout.tie(NULL);
    cin >> V >> E >> K;
    for (int i = 0; i < E; i++) {
        int u, v, w;
        cin >> u >> v >> w;
        graph[u].push_back(make_pair(v, w));
    }
    
    vector<int> result = dijkstra(K, V+1);
    for (int i = 1; i < result.size(); i++) {
        if (result[i] == INF){
            cout << "INF\n";
        }
        else {
            cout << result[i] << "\n";
        }

    }
    


    return 0;
}