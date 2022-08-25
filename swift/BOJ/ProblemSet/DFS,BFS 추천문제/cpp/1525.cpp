// https://ethical-hack.tistory.com/29 

#include <iostream> 
#include <string>  
#include <algorithm> 
#include <queue> 
#include <set> 
using namespace std; 

string box, result ;
queue<pair<string, int> > Q; 
set<string> visit ; 
int dx[4] = {-1, 0, 1, 0} ; 
int dy[4] = {0, 1, 0, -1} ; 
void Input() {
    result = "123456780"; 
    int arr[3][3] ; 
    for (int i = 0 ; i < 3 ; i++) { 
        for (int j = 0 ; j < 3; j++) { 
	    cin >> arr[i][j] ;  
	    box += ('0' + arr[i][j]); 
	}
    }	
}

void BFS() { 
    Q.push(make_pair(box, 0)); 
    visit.insert(box); 

    while(!Q.empty()) { 
        string curr = Q.front().first ; 
	int count = Q.front().second  ;
		
	Q.pop() ;
	if (curr == result) { 
	    cout << count << '\n' ; 
            return ; 
	}
		
	int zero_location = curr.find('0'); 
	int zero_x = zero_location / 3 ; 
	int zero_y = zero_location % 3 ; 

	for(int i = 0 ; i < 4 ; i++) { 
	    int dir_zero_x = zero_x + dx[i] ; 
	    int dir_zero_y = zero_y + dy[i] ; 

	    if (dir_zero_x < 0 || dir_zero_x > 2 || dir_zero_y < 0 || dir_zero_y > 2) continue;  
	        string next = curr ; 
		swap(next[dir_zero_x * 3 + dir_zero_y], next[zero_x * 3 + zero_y]); 
		if (visit.find(next) == visit.end()) { 
	       	    visit.insert(next) ; 
		    Q.push(make_pair(next, count + 1)) ; 		
		}
	    }
	}
    cout << "-1" << '\n' ; 
    return ;
}
int main(void) 
{
    ios::sync_with_stdio(false); 
    cin.tie(0); cout.tie(0); 
    Input() ;
    BFS() ; 	
}