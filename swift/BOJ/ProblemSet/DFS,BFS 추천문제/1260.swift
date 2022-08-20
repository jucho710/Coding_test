import Foundation
let input = readLine()!.split(separator: " ").map {Int(String($0))!}
let (n, m, v) = (input[0], input[1], input[2])
var graph: [[Int]] = Array(repeating: [], count: n+1)
var visited = Array(repeating: false, count: n+1)
var answer = ""

for _ in 0..<m {
  let input = readLine()!.split(separator: " ").map {Int(String($0))!}
  let (a, b) = (input[0], input[1])
  graph[a].append(b)
  graph[b].append(a)
  // 정점이 작은 것부터 방문해야 해 정렬
  graph[a].sort()
  graph[b].sort()
}

func DFS(_ v: Int) {
  visited[v] = true
  answer += "\(v) "
  for i in graph[v] {
    if !visited[i] {
      DFS(i)
    }
  }
}

func BFS(_ v: Int) {
  var visited = Array(repeating: false, count: n+1)
  var queue = [v]
  
  while queue.count != 0 {
    let node = queue.removeFirst()
    if !visited[node] {
      visited[node] = true
      answer += "\(node) "
      queue.append(contentsOf: graph[node])
    }
  }
}

DFS(v)
print(answer)
answer = ""
BFS(v)
print(answer)
