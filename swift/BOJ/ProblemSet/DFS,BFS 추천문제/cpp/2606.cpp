// https://guiyum.tistory.com/40

#include <iostream>
#include <vector>
using namespace std;
vector<int> a[101]; // 인접 리스트
bool check[101];
int count = 0;

void DFS(int x) {
    check[x] = true;
    for (int i = 0; i < a[x].size(); i++) {
        int y = a[x][i];
        if (!check[y]){
            DFS(y);
            count++;
        }
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);


    int N, M;   // N: 노드 개수,  M: Edge 개수
    for (int i = 0; i < M; i++) {
        int u, v;
        cin >> u >> v;
        a[u].push_back(v);
        a[v].push_back(u);
    }
    DFS(1);
    cout << count << "\n";

    return 0;
}