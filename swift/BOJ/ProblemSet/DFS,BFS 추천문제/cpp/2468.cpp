// https://gangdor.tistory.com/51 

#include <stdio.h>
#define MAX (int)1e6

int N;
int map[100+10][100+10];
int visit[100+10][100+10];
int minH=MAX;
int maxH=0;
int cnt;

int dx[4]={-1,1,0,0};
int dy[4]={0,0,-1,1};

void Input()
{
	scanf("%d", &N);
	
	for(int i=0; i<N; i++)
	{
		for(int j=0; j<N; j++)
		{
			scanf("%d", &map[i][j]);
		}
	}
}

void FindHeight()
{
	for(int i=0; i<N; i++)
	{
		for(int j=0; j<N; j++)
		{
			if(map[i][j]>maxH) maxH = map[i][j];
			if(map[i][j]<minH) minH = map[i][j];
		}
	}
}

void MakeMap(int h)
{
	for(int i=0; i<N; i++)
	{
		for(int j=0; j<N; j++)
		{
			if(map[i][j]<=h) visit[i][j]=-1;
		}
	}
}

void Initvisit()
{
	for(int i=0; i<N; i++)
	{
		for(int j=0; j<N; j++)
		{
			visit[i][j]=0;
		}
	}
}

void Dfs(int x, int y)
{
	if(visit[x][y]!=0)
	{
		return;
	}
	
	visit[x][y]=1;
	
	for(int i=0; i<4; i++)
	{
		int nx = x + dx[i];
		int ny = y + dy[i];
		
		if(0>nx || nx>N-1 || 0>ny || ny>N-1) continue;
		if(visit[nx][ny]!=0) continue;
		Dfs(nx,ny);
	}
}


int main() {
	int ans=-1;
	Input();
	FindHeight();
	//printf("%d %d", minH, maxH);
	
	for(int i=minH; i<=maxH; i++) //빗물의 높이는 minH~maxH, i는 빗물의 범위
	{
		cnt=0;
		Initvisit();
		//map만들기, map은 보존해야하기 때문에
		MakeMap(i);
		
		for(int i=0; i<N; i++){
			for(int j=0; j<N; j++)
			{
				if(visit[i][j]==0)
				{
					cnt++;
					Dfs(i,j);
				}
			}
		}
		
		if(cnt >= ans) ans = cnt;
	}
	
	if(ans==0) ans=1;
	printf("%d", ans);
	return 0;
}