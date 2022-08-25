// https://www.acmicpc.net/source/29779451 

let inp = readLine()!.split(separator : " " ).map{Int(String($0))!}
let row = inp[1], col = inp[0]
var arr = [[[Int]]]()

for _ in 0..<row {
    let q = readLine()!.split(separator : " " ).map{Int(String($0))!}
    let tempt: [[Int]] = q.map{ int in
        var s = String(int,radix:2)
        while s.count < 4 {
            s.insert("0", at: String.Index(utf16Offset: 0, in: s))
        }
        return s.map{Int(String($0))!}
    }
    arr.append(tempt)
}

var rooms = 0
var maxArea = 0
var maxAreaRemoving = 0

let dir = [(1,0),(0,1),(-1,0),(0,-1)]
var visit = Array(repeating: Array(repeating: false, count: col), count: row)
var groups = Array(repeating: Array(repeating: 0, count: col), count: row)
var groupsArea = Array(repeating: 0, count: row*col+1)

func bfs(_ cur: (Int,Int)) -> (Int ) {
    var queue = [cur]
    var q = 0
    visit[cur.0][cur.1] = true
    groups[cur.0][cur.1] = rooms
    while queue.count>q {
        let f = queue[q]
        q += 1
        for i in 0..<4 {
            if arr[f.0][f.1][i] == 1 { continue }
            let n = (f.0+dir[i].0, f.1+dir[i].1)
            if n.0>=row||n.1>=col||n.0<0||n.1<0{continue}
            if visit[n.0][n.1] { continue }
            visit[n.0][n.1] = true
            queue.append(n)
            groups[n.0][n.1] = rooms
        }
    }
    groupsArea[rooms] = queue.count
    return queue.count
    
}
for i in 0..<row {
    for j in 0..<col {
        if visit[i][j] { continue }
        rooms += 1
        maxArea = max(maxArea, bfs((i,j)))
    }
}
maxAreaRemoving = maxArea

for i in 0..<row {
    for j in 0..<col {
        for k in 0..<4 {
            if arr[i][j][k] == 1 {
                let n = (i+dir[k].0, j+dir[k].1)
                if n.0>=row||n.1>=col||n.0<0||n.1<0{continue}
                let A = groups[n.0][n.1]
                let B = groups[i][j]
                if A == B { continue }
                maxAreaRemoving = max(maxAreaRemoving, groupsArea[A] + groupsArea[B])
            }
        }
    }
}

print(rooms)
print(maxArea)
print(maxAreaRemoving)