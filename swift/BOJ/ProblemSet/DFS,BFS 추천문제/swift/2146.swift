// https://www.acmicpc.net/source/9284669

let n = Int(readLine()!)!
let dx = [1, 0, -1, 0], dy = [0, 1, 0, -1]

var map = [[Int]](repeating: [Int](repeating: -1, count: n+2), count: n+2)

for i in 1...n {
    let input = readLine()!.split{$0 == " "}.map{Int($0)!}
    for j in 1...n {
        map[i][j] = input[j-1]
    }
}

var p = 2, head = 0
var queue = [(Int, Int)]()

for i in 1...n {
    for j in 1...n {
        if map[i][j] == 1 {
            queue = [(i, j)]
            head = 0
            map[i][j] = p
            while head < queue.count {
                let (x, y) = queue[head]
                head += 1
                for k in 0..<4 {
                    let (nx, ny) = (x+dx[k], y+dy[k])
                    if map[nx][ny] == 1 {
                        queue.append((nx, ny))
                        map[nx][ny] = p
                    }
                }
            }
            p += 1
        }
    }
}

var v = [[Int]](repeating: [Int](repeating: 0, count: n+2), count: n+2)
queue = []
head = 0

for i in 1...n {
    for j in 1...n {
        if map[i][j] > 0 {
            queue.append((i, j))
        }
    }
}

var res = Int.max

while head < queue.count {
    let (x, y) = queue[head]
    head += 1
    for i in 0..<4 {
        let (nx, ny) = (x+dx[i], y+dy[i])
        if map[nx][ny] == 0 {
            map[nx][ny] = map[x][y]
            v[nx][ny] = v[x][y] + 1
            queue.append((nx, ny))
        } else if map[nx][ny] > 0 {
            if map[nx][ny] != map[x][y] {
                res = min(res, v[x][y] + v[nx][ny])
            }
        }
    }
}

print(res)