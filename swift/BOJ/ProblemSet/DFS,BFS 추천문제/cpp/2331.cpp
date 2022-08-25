// https://miiinnn23.tistory.com/50

#include <cstdio>
#include <vector>
#include <cmath>
#define MAX 1000000

using namespace std;

vector<int> visited(MAX, 0);
void DFS(int num, int P);

int main(void) {
    int A, P;
    scanf("%d %d", &A, &P);
    DFS(A, P);
    
    int count = 0;
    for(int i = 0; i <= MAX; i++) {
        if(visited[i] == 1)
            count++;
        else
            continue;
    }

    printf("%d\n", count);
    return 0;
}

int calc(int A, int P) {
    int temp = A;
    int sum = 0;
    while(temp > 0) {
        sum += (int)(pow(temp % 10, P));
        temp /= 10;
    }
    return sum;
}

void DFS(int num, int P) {
    visited[num]++;
    if(visited[num] > 2) return; // 반복되는 수가 한바퀴 돌았을 때 멈춤
    DFS(calc(num, P), P);
}