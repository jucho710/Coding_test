// https://www.acmicpc.net/source/45869276

var input = readLine()!.split(separator: " ").map({Int(String($0))!})
let N = input[0]
let M = input[1]
var nums: [[Int]] = []
for _ in 0..<N {
    let temp = Array(readLine()!).map {Int(String($0))!}
    nums.append(temp)
}
var queue = [(0, 0)]
let (dx, dy) = ([-1, 1, 0, 0], [0,0,1,-1])

while !queue.isEmpty {
    let (x, y) = queue.removeFirst()
    for i in 0..<4 {
        let nx = x + dx[i], ny = y + dy[i]
        if nx < 0 || ny < 0 || nx >= N || ny >= M {continue}
        if nums[nx][ny] == 0 {continue}
        if nums[nx][ny] == 1 {
            nums[nx][ny] = nums[x][y] + 1
            queue.append((nx, ny))
        }
    }
}
print(nums[N - 1][M - 1])