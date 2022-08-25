// https://www.acmicpc.net/source/42775294

let N = Int(readLine()!)!
var height = [[Int]]()
var minRange = 100
var maxRange = 1
for i in 0..<N {
    height.append(readLine()!.split(separator: " ").map{Int($0)!})
    minRange = min(minRange, height[i].min()!)
    maxRange = max(maxRange, height[i].max()!)
}

let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
var maxCount = 0

for rain in minRange - 1...maxRange {
    var copyheight = height
    var count = 0
    for i in 0..<N {
        for j in 0..<N {
            if copyheight[i][j] > rain {
                count += 1
                var queue = [(Int, Int)]()
                copyheight[i][j] = rain
                queue.append((i, j))

                while !queue.isEmpty {
                    let (x, y) = queue.removeFirst()
                    for dir in directions {
                        let (nx, ny) = (x + dir.0, y + dir.1)
                        if (0..<N).contains(nx) && (0..<N).contains(ny) && copyheight[nx][ny] > rain {
                            copyheight[nx][ny] = rain
                            queue.append((nx, ny))
                        }
                    }
                }
            }
        }
    }
    maxCount = max(maxCount, count)
}

print(maxCount)