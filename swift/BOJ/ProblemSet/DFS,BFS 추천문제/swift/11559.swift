// https://www.acmicpc.net/source/34744277 

import Foundation
var graph = [[Character]]()

//4개이상이면 터트리기
func bfs(_ x: Int, _ y: Int, _ c: Character, _ visited: inout [[Bool]]) -> Bool{
	let dx = [1,-1,0,0]
	let dy = [0,0,1,-1]
	
	var deleteList = [(x,y)]

	var queue = [(x,y)]
	var idx = 0

	while queue.count > idx {
		let (cx,cy) = queue[idx]
		idx += 1
		for i in 0..<4 {
			let (nx,ny) = (cx+dx[i],cy+dy[i])
			if (0..<12).contains(nx) && (0..<6).contains(ny) && graph[nx][ny] == c && !visited[nx][ny]{
				visited[nx][ny] = true
				deleteList.append((nx,ny))
				queue.append((nx,ny))
			}
		}
	}

	if deleteList.count >= 4 {
		deleteList.forEach{graph[$0.0][$0.1] = "."}
		return true
	} else {return false}
}

func gravity() {
	for j in 0...5 {
		for i in stride(from: 11, to: -1, by: -1) {
			if graph[i][j] == "." {
				//문자가 있는 구간을 찾는다..!
				for k in stride(from: i-1, to: -1, by: -1) {
					if graph[k][j] != "." {
						graph[i][j] = graph[k][j]
						graph[k][j] = "."
						break
					}
				}
			}
		}
	}
}

for _ in 0..<12 {
	let line = Array(readLine()!)
	graph.append(line)
}

var ans = 0

while true {
	var boom = false
	var visited = Array(repeating: Array(repeating: false, count: 6), count: 12)

	for i in 0..<12 {
		for j in 0..<6 {
			if graph[i][j] != "." && !visited[i][j]{
				visited[i][j] = true
				if bfs(i,j,graph[i][j],&visited) {boom = true}
			}
		}
	}

	if boom {
		ans += 1
		gravity()
	} else {
		break
	}
}

print(ans)
