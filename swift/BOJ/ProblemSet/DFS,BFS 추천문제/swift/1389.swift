// https://www.acmicpc.net/source/24502583

let input = readLine()!.split(separator : " ").map{Int(String($0))!}
let N = input[0], M = input[1]

var nodes = Array(repeating : [Int](), count : N+1)

for _ in 0..<M {
    let q = readLine()!.split(separator : " ").map{Int(String($0))!}
    nodes[q[0]].append(q[1])
    nodes[q[1]].append(q[0])
}


func bfs(_ start : Int ) -> Int  {
    var queue = [(start,0)]
    var visit = Array(repeating : false, count : N+1)
    visit[start] = true
    var total = 0
    while !queue.isEmpty {
        let f = queue.removeFirst()
        
        for n in nodes[f.0] {
            if visit[n] { continue }
            visit[n] = true
            total += f.1+1
            queue.append((n,f.1+1))
        }
    }
    return total
}

var answer = (987654321,0)
for i in 1...N {
    let c = bfs(i)
    if answer.0 > c {
        answer = (c,i)
    }
}
print(answer.1)
