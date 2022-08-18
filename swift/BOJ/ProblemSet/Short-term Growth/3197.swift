// https://www.acmicpc.net/source/45146797

let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let (R, C) = (input[0], input[1])

var visit = Array(repeating: Array(repeating: false, count: C), count: R)
let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

var map = [[String]]()
var sx = -1
var sy = -1
var ex = -1
var ey = -1
var swanQueue: [(Int, Int)] = []
var waterQueue: [(Int, Int)] = []

for i in 0..<R {
    map.append(readLine()!.map{ String($0) })
    for j in 0..<C {
        if map[i][j] == "L" {
            if sx == -1 && sy == -1 {
                sx = i; sy = j
            } else {
                ex = i; ey = j
            }
            map[i][j] = "."
            waterQueue.append((i, j))
        } else if map[i][j] == "." {
            waterQueue.append((i, j))
        }
    }
}

func meltIce() {
    var nextWaterQueue: [(Int, Int)] = []
    var front = 0
    while front < waterQueue.count {
        let node = waterQueue[front]
        front += 1
        let x = node.0
        let y = node.1

        for i in 0...3 {
            let nX = x + dx[i]
            let nY = y + dy[i]

            if nX < 0 || nY < 0 || nX >= R || nY >= C {
                continue
            }
            if map[nX][nY] == "X" {
                map[nX][nY] = "."
                nextWaterQueue.append((nX, nY))
            }
        }
    }
    waterQueue = nextWaterQueue
}

func bfs() -> Bool {
    var nextSwanQueue: [(Int, Int)] = []
    var front = 0

    while front < swanQueue.count {
        let node = swanQueue[front]
        front += 1
        let x = node.0
        let y = node.1
        
        if x == ex && y == ey {
            return true
        }
        for i in 0...3 {
            let nX = x + dx[i]
            let nY = y + dy[i]

            if nX < 0 || nY < 0 || nX >= R || nY >= C || visit[nX][nY] {
                continue
            }
            visit[nX][nY] = true
            if map[nX][nY] == "X" {
                nextSwanQueue.append((nX, nY))
                continue
            }
            swanQueue.append((nX, nY))
        }
    }
    swanQueue = nextSwanQueue
    
    return false
}

swanQueue = [(sx, sy)]
visit[sx][sy] = true

var answer = 0
while true {
    if bfs() { break }
    meltIce()
    answer += 1
}

print(answer)