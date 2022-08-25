// https://wooono.tistory.com/414 

#include <iostream>
#include <queue>
#define MAX 51
#include <typeinfo>
using namespace std;

// 지도 크기
int R, C;

// 지도
char map[MAX][MAX];

// 비버 소굴 위치
pair<int, int> beaver_nest;

// 물 확장용 큐
queue<pair<int, int> > water_q;

// 고슴도치 이동용 큐
queue<pair<int, int> > hedgehog_q;

// 상하좌우 이동용 배열
int dx[4] = {-1, 1, 0, 0};
int dy[4] = {0, 0, -1, 1};

// 고슴도치가 비버 소굴까지 안전하게 갈 수 있는 최소 시간
int result_time;

void bfs(){

    // 고슴도치가 더 이상 이동할 수 없을때까지
    while(!hedgehog_q.empty()){

        // 물 확장이 시작되는 위치들
        int water_start_count = water_q.size();

        // 물 확장이 시작되는 위치들을 모두 탐색
        for (int i=0; i<water_start_count; ++i){

            // 물 확장용 큐의 first 추출
            int current_water_x = water_q.front().first;
            int current_water_y = water_q.front().second;

            // 물 확장용 큐의 first 제거
            water_q.pop();

            // 물의 현재 위치에서 상하좌우로 인접한 공간 탐색
            for (int i=0; i<4; ++i){

                // 물의 현재 위치에서 상하좌우로 인접한 공간 좌표
                int next_water_x = current_water_x + dx[i];
                int next_water_y = current_water_y + dy[i];

                // 인접 좌표가 지도 안에 있는지, 비어있는 공간인지 확인
                if ((0 <= next_water_x && next_water_x < R) && (0 <= next_water_y && next_water_y < C) 
                && map[next_water_x][next_water_y] == '.'){

                    // 물 확장용 큐에, 인접 좌표를 삽입
                    water_q.push(make_pair(next_water_x, next_water_y));

                    // 지도 내에서 해당 인접 좌표를, 물이 확장된 위치로 변경
                    map[next_water_x][next_water_y] = '*';
                }
            }
        }

        // 고슴도치 이동이 시작되는 위치들
        int hedgehog_start_count = hedgehog_q.size();

        for (int i=0; i<hedgehog_start_count; ++i){

            // 고슴도치 이동용 큐의 first 추출
            int current_hedgehog_x = hedgehog_q.front().first;
            int current_hedgehog_y = hedgehog_q.front().second;

            // 고슴도치 이동용 큐의 first 제거
            hedgehog_q.pop();

            // 고슴도치의 현재 위치에서 상하좌우로 인접한 공간 탐색
            for (int i=0; i<4; ++i){

                // 고슴도치의 현재 위치에서 상하좌우로 인접한 공간 좌표
                int next_hedgehog_x = current_hedgehog_x + dx[i];
                int next_hedgehog_y = current_hedgehog_y + dy[i];

                // 인접 좌표가 비버 소굴이면 함수 종료
                if ((next_hedgehog_x == beaver_nest.first) && (next_hedgehog_y == beaver_nest.second)){
                    result_time++;
                    cout << result_time;
                    return;
                }

                // 인접 좌표가 지도 안에 있는지, 비어있는 공간인지 확인
                if ((0 <= next_hedgehog_x && next_hedgehog_x < R) && (0 <= next_hedgehog_y && next_hedgehog_y < C) 
                && map[next_hedgehog_x][next_hedgehog_y] == '.'){

                    // 고슴도치 확장용 큐에, 인접 좌표를 삽입
                    hedgehog_q.push(make_pair(next_hedgehog_x, next_hedgehog_y));

                    // 지도 내에서 해당 인접 좌표를, 고슴도치가 이동한 위치로 변경
                    map[next_hedgehog_x][next_hedgehog_y] = 'S';
                }
            }
        }

        // 고슴도치가 비버 소굴까지 가고 있는 시간
        result_time++;
    }

    // 고슴도치가 비버 소굴을 찾지 못했다면
    cout << "KAKTUS";

    return;
}

int main(){

    // 지도 크기 입력
    cin >> R >> C;

    string row;
    for (int i=0; i<R; ++i){
        // 행 입력
        cin >> row;
        for (int j=0; j<C; ++j){
            // 행 별로, 지도 내부 좌표값 채우기
            map[i][j] = row[j];
            // 좌표값이 고슴도치 시작 위치라면, 고슴도치 이동용 큐에 삽입
            if (row[j] == 'S'){
                hedgehog_q.push(make_pair(i,j));
            }
            // 좌표값이 비버 소굴 위치라면, 별도로 저장
            else if (row[j] == 'D'){
                beaver_nest = make_pair(i,j);
            }
            // 좌표값이 물 시작 위치라면, 물 확장용 큐에 삽입
            else if (row[j] == '*'){
                water_q.push(make_pair(i,j));
            }
        }
    }

    // bfs 시작
    bfs();

}