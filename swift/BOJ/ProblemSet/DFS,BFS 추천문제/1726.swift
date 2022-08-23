// https://www.acmicpc.net/source/24505191

let input = readLine()!.split(separator : " ").map{Int(String($0))!}
let N = input[0], M = input[1]

var arr = [[Int]]()

for _ in 0..<N {
    let q = readLine()!.split(separator : " ").map{Int(String($0))!}
    arr.append(q)
}

let dir = [(0,1),(0,-1),(1,0),(-1,0)]

let input2 = readLine()!.split(separator : " ").map{Int(String($0))!}
let sr = input2[0]-1, sc = input2[1]-1, sd = input2[2]-1

let input3 = readLine()!.split(separator : " ").map{Int(String($0))!}
let er = input3[0]-1, ec = input3[1]-1, ed = input3[2]-1


var dp = Array(repeating : Array(repeating : Array(repeating : 987654321,count:4),count:M),count:N)

dp[sr][sc][sd] = 0

var D = Array(repeating :-1,count:4)
D[0] = 1
D[1] = 0
D[3] = 2
D[2] = 3

func bfs() {
    var queue : [(pos:(Int,Int),dir:Int,cost:Int)] = [((sr,sc),sd,0)]
    
    while !queue.isEmpty {
        let f = queue.removeFirst()
        if f.pos == (er,ec) {
            if f.dir != ed {
                if D[f.dir] == ed {
                    if dp[er][ec][ed] > f.cost+2 {
                        dp[er][ec][ed] = f.cost+2
                    }
                }else  {
                    if dp[er][ec][ed] > f.cost+1 {
                        dp[er][ec][ed] = f.cost+1
                    }
                }
            }
            continue
        }
        
        for i in 0..<4 {
            var next = (f.pos.0 + dir[i].0, f.pos.1 + dir[i].1)
            if next.0 >= N || next.1 >= M || next.0 < 0 || next.1 < 0 { continue }
            if arr[next.0][next.1] == 1 { continue }
            var nextCost = f.cost+1
            if D[f.dir] == i {
                nextCost += 2
            }else if f.dir != i {
                nextCost += 1
            }
            if dp[next.0][next.1][i] > nextCost {
                dp[next.0][next.1][i] = nextCost
                queue.append((next,i,nextCost))
            }
            for _ in 1..<3 {
                let nextj = (next.0 + dir[i].0, next.1 + dir[i].1)
                if nextj.0 >= N || nextj.1 >= M || nextj.0 < 0 || nextj.1 < 0 { continue }
                if arr[nextj.0][nextj.1] == 1 { continue }
                if dp[nextj.0][nextj.1][i] > nextCost {
                    dp[nextj.0][nextj.1][i] = nextCost
                    queue.append((nextj,i,nextCost))
                }
                next = nextj
            }
            
            
        }
    }
    print(dp[er][ec][ed])
    
}

bfs()