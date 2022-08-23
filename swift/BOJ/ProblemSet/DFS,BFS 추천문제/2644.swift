// https://www.acmicpc.net/source/27079732

let N = Int(readLine()!)!
let inp = readLine()!.split(separator: " " ).map{Int(String($0))!}
let start = inp[0], end = inp[1]
let M = Int(readLine()!)!
var nodes = Array(repeating: [Int](), count: N+1)
for _ in 0..<M {
    let q = readLine()!.split(separator: " " ).map{Int(String($0))!}
    nodes[q[0]].append((q[1]))
    nodes[q[1]].append((q[0]))
}
var stack = [(start,0)]
var visit = Array(repeating: false, count: N+1)
visit[start] = true
var answer = -1
while !stack.isEmpty {
    let node = stack.removeLast()
    if node.0 == end { answer = node.1; break}
    for next in nodes[node.0] {
        if visit[next] { continue }
        visit[next] = true
        stack.append((next,node.1+1))
    }
}
print(answer)
