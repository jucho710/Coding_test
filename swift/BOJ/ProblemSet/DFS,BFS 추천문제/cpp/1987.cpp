// https://wooono.tistory.com/307

#include <iostream>
#include <algorithm>
#define MAX 20
using namespace std;

// 입력
int r, c;

// 알파벳을 담고 있는 보드 행렬
char board[MAX][MAX];

// 방문한 알파벳
int alphabet[26] = {0};

// row index 변화 목록 (상, 하, 좌, 우)
int dx[4] = {-1, 1, 0, 0};

// col index 변화 목록 (상, 하, 좌, 우)
int dy[4] = {0, 0, -1, +1};

// 말이 지날 수 있는 최대 경로 길이
int max_path = 0;

// 상하좌우 경로 탐색 (행, 열, 현재까지 찾은 경로의 길이)
void dfs(int row, int col, int find_path){

    // 현재까지 찾은 경로가 max_path보다 길다면, max_path 수정
    max_path = max(find_path, max_path);

    // 상하좌우에 따라 row, col 값 변경
    for (int i=0; i<4; ++i){
        int new_row = row + dx[i];
        int new_col = col + dy[i];

        // 상하좌우로 움직일 수 있는지 확인
        if (0 <= new_row && new_row < r && 0 <= new_col && new_col < c){

            // 이동할 지점의 알파벳이 이전에 방문한 알파벳인지 확인한 후, 방문 가능하다면
            if (!alphabet[((int)board[new_row][new_col])-65]){

                // 현재 위치의 알파벳을 방문한 알파벳으로 저장
                alphabet[((int)board[new_row][new_col])-65]++;

                // 해당 정보들을 가지고 dfs 탐색 시작
                dfs(new_row, new_col, find_path+1);    

                // 상단의 재귀함수가 끝났다면, 인접한 다른 경로도 확인해야하므로
                // 현재 위치의 알파벳을 방문하지 않은 알파벳으로 변경
                alphabet[((int)board[new_row][new_col])-65]--;

            }
        }
    }
}

int main(void){

    // r, c 입력
    cin >> r >> c;

    // 알파벳을 입력 받아 보드에 저장
    for(int i=0; i<r; ++i){
        for (int j=0; j<c; ++j){
            cin >> board[i][j];
        }
    }

    // 0,0 은 방문한 알파벳으로 저장
    alphabet[((int)board[0][0])-65]++;

    // 경로 탐색 함수 호출
    dfs(0,0,1);

    // 출력
    cout << max_path << endl;

    return 0;

}