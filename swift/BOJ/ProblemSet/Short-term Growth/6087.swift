// https://www.acmicpc.net/source/34689386

import Foundation

let t = readLine()!.split(separator: " ").map{Int(String($0))!}
let (W,H) = (t[0],t[1])

var visited = Array(repeating: Array(repeating: Array(repeating: -1, count: 4), count: W), count: H)

var pos = [(Int,Int)]()
var graph = [[Character]]()
for i in 0..<H {
	let input = Array(readLine()!)
	for j in 0..<W {
		if input[j] == "C" {pos.append((i,j))}
	}
	graph.append(input)
}

let (sx,sy) = pos[0]

//상좌하우
let dx = [-1,0,1,0]
let dy = [0,1,0,-1]

//좌측, 직진, 우측

visited[sx][sy] = [0,0,0,0]

func bfs(_ x: Int, _ y: Int, _ cnt: Int) {
	var queue = [(Int,Int,Int)]()
	for i in 0..<4 {
		let (nx,ny) = (x+dx[i],y+dy[i])
		if (0..<H).contains(nx) && (0..<W).contains(ny) && graph[nx][ny] != "*" {
			visited[nx][ny][i] = 0
			queue.append((nx,ny,i))
		}
	}
	var idx = 0
	while queue.count > idx {
		let (cx,cy,cr) = queue[idx]
		idx += 1

		if cx == pos[1].0 && cy == pos[1].1 {
			//return
		}

		for i in 0..<4 {
			if (i+2) % 4 == cr {continue}
			let (nx,ny) = (cx+dx[i],cy+dy[i])
			if (0..<H).contains(nx) && (0..<W).contains(ny) && graph[nx][ny] != "*"{
				if i == cr {
					if visited[nx][ny][i] == -1 || visited[nx][ny][i] > visited[cx][cy][cr] {
						visited[nx][ny][i] = visited[cx][cy][cr]
						queue.append((nx,ny,i))
					}
				} 
				else {
					if visited[nx][ny][i] == -1 || visited[nx][ny][i] > visited[cx][cy][cr] + 1{
						visited[nx][ny][i] = visited[cx][cy][cr] + 1
						queue.append((nx,ny,i))
					}
				}
			}
		}
	}
}

bfs(sx,sy,0)

let ans = visited[pos[1].0][pos[1].1].filter{$0 != -1}.min()!

print(ans)