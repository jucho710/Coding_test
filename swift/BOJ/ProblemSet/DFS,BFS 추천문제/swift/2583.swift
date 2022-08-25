// https://www.acmicpc.net/source/27131042 

let firstLine = readLine()!.split(separator: " ").map{Int(String($0))!}
let m = firstLine[0]
let n = firstLine[1]
let k = firstLine[2]

var graph: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)

for _ in 0..<k {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let x1 = line[0]
    let y1 = line[1]
    let x2 = line[2]
    let y2 = line[3]
    for x in x1..<x2 {
        for y in y1..<y2 {
            graph[y][x] = 1
        }
    }
}

var width: [Int] = []
let dx = [1,-1,0,0]
let dy = [0,0,1,-1]

for i in 0..<m {
    for j in 0..<n {
        if graph[i][j] == 0 {
            width.append(dfs(i,j))
        }
    }
}
print(width.count)
for w in width.sorted() {
    print(w,terminator: " ")
}

func dfs(_ i: Int, _ j: Int) -> Int {
    var stack = [(i,j)]
    var cnt = 0
    while !stack.isEmpty {
        let now = stack.popLast()!
        if graph[now.0][now.1] == 2 {
            continue
        }
        graph[now.0][now.1] = 2
        cnt += 1
        
        for k in 0..<4 {
            let nx = now.0 + dx[k]
            let ny = now.1 + dy[k]
            if nx>=0 && nx<m && ny>=0 && ny<n && graph[nx][ny] == 0 {
                stack.append((nx,ny))
            }
        }
    }
    return cnt
}