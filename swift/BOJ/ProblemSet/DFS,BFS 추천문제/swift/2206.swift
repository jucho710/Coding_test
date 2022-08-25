// https://www.acmicpc.net/source/18173976

import Foundation

let dx = [1,0,-1,0]
let dy = [0,1,0,-1]

struct Point {
    let p: Int
    let canBreak: Int
}

let nm = readLine()!.split(separator: " ").map({ Int($0)! })
let n = nm[0]
let m = nm[1]

var visited = Array(repeating: Array(repeating: false, count: n*m), count: 2)
let vp = [UnsafeMutableBufferPointer(start: &visited[0], count: n*m), UnsafeMutableBufferPointer(start: &visited[1], count: n*m)]
var arr: [Int] = Array(repeating: 0, count: n*m)

let p = UnsafeMutableBufferPointer(start: &arr, count: n*m)

for i in 0..<n {
    let line = readLine()!.map({ Int($0.asciiValue! - 48) })

    for j in 0..<m {
        p[i*m+j] = line[j]
    }
}

var q: [Point] = []
q.append(Point(p: 0, canBreak: 1))

var answer = 0;

while q.isEmpty == false {

    let count = q.count
    var nq: [Point] = []
    let qp = UnsafeBufferPointer(start: q, count: count)

    for i in 0..<count {
        let current = qp[i]

        if vp[current.canBreak][current.p] { continue }

        vp[current.canBreak][current.p] = true

        let cx = current.p % m;
        let cy = current.p / m;

        for k in 0..<4 {
            let nx = cx + dx[k]
            let ny = cy + dy[k]

            if nx<0 || nx >= m || ny<0 || ny >= n { continue }

            let np = ny*m+nx

            if p[np] == 1 {
                if current.canBreak == 1 , !vp[0][np] {
                    nq.append(Point(p: np, canBreak: 0))
                }
            } else if !vp[current.canBreak][np]{
                nq.append(Point(p: np, canBreak: current.canBreak))
            }
        }
    }

    q = nq

    answer += 1

    if vp[0].last == true || vp[1].last == true { break }
}

if vp[0].last == true || vp[1].last == true {
    print(answer)
} else {
    print(-1)
}