#include <iostream>
#include <queue>
#include <algorithm>
#define INF 10000

using namespace std;

int N;
int map[125][125], cost[125][125];


const int dy[] = {0, +1, 0, -1};
const int dx[] = {+1, 0, -1, 0};

int solve()
{
    for (int y = 0; y < N; ++y)
        for (int x = 0; x < N; ++x)
            cost[y][x] = INF;
    cost[0][0] = map[0][0];
    queue<pair<int, pair<int, int>>> q;
    q.push(make_pair(cost[0][0], make_pair(0, 0)));
    while(!q.empty()) {
        int curCost = q.front().first;
        int cy = q.front().second.first, cx = q.front().second.second;
        q.pop();
        if (cost[cy][cx] < curCost) continue;

        for (int dir = 0; dir < 4; dir++){
            int ny = cy + dy[dir];
            int nx = cx + dx[dir];

            if (ny < 0 || ny >= N || nx < 0 || nx >= N) continue;
            
            int newCost = cost[cy][cx] + map[ny][nx];
            if (cost[ny][nx] > newCost){
                cost[ny][nx] = newCost;
                q.push(make_pair(newCost, make_pair(ny, nx)));
            }
        }

    }


    return cost[N-1][N-1];
}



int main()
{

    ios_base::sync_with_stdio(false);   cin.tie(NULL);  cout.tie(NULL);
    int count = 0;
    while(true){
        ++count;
        cin >> N;
        if (N == 0) break;
        for (int y = 0; y < N; ++y)
            for (int x = 0 ; x < N; ++x)
                cin >> map[y][x];
        
        int result = solve();
        cout << "Problem " << count << ": " << result << "\n";
 
    }


    return 0;
}