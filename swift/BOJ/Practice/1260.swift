import Foundation

let input: [Int] = readLine()!.split(separator: " ").map { Int($0)!}
let nodes: Int = input[0]
let edges: Int = input[1]
let startNode: Int = input[2]

var map: [[Int]] = Array(repeating: [Int](), count: nodes + 1)

for _ in 0..<edges {
    let edge: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
    let from: Int = edge[0]
    let to: Int = edge[1]

    map[from].append(to)
    map[to].append(from)
}

for i in 0...nodes {
    map[i].sort()
}

var visited: [Bool] = Array(repeating: false, count: nodes + 1)
var stack: [Int] = [Int]()

func dfs(_ node: Int) {
    visited[node] = true
    print(node, terminator: " ")

    for i in 0..<map[node].count {
        if visited[map[node][i]] { continue }
        stack.append(map[node][i])
        if !stack.isEmpty {
            dfs(stack.removeLast())
        }
    }
}

dfs(startNode)
print()

var queue: [Int] = [Int]()
func bfs(_ node: Int) {
    queue.append(node)
    var idx: Int = 0

    while idx <= nodes {
        if idx >= queue.count { break }
        let cur: Int = queue[idx]
        for i in 0..<map[cur].count {
            if queue.contains(map[cur][i]) { continue }
            queue.append(map[cur][i])
        }
        idx += 1
    }

    queue.forEach{ print($0, terminator: " ")}
}

bfs(startNode)