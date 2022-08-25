// https://www.acmicpc.net/source/24857150

let N = Int(readLine()!)!
let M = Int(readLine()!)!
var nodes = Array(repeating : [Int](),count:N+1)
for _ in 0..<M {
    let inp = readLine()!.split(separator : " " ).map{Int(String($0))!}
    nodes[inp[0]].append(inp[1])
    nodes[inp[1]].append(inp[0])
}

var visit = Array(repeating : false, count  : N+1)
var count = 0

func dfs(_ cur : Int ) {
    visit[cur] = true
    
    for n in nodes[cur] {
        if visit[n] { continue }
        count+=1
        dfs(n)
    }
}

dfs(1)
print(count)