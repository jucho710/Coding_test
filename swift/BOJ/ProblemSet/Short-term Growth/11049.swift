// https://www.acmicpc.net/source/27427727

let n = Int(readLine()!)!
var arr:[[Int]] = []
var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
for _ in 1...n {
    arr.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}
for d in 1..<n {
    for x in 0..<n-d {
        let y = x + d
        var result = 65_000_000_000
        for k in x..<y {
            result = min(result, dp[x][k] + dp[k+1][y] + arr[x][0]*arr[k][1]*arr[y][1])
        }
        dp[x][y] = result
    }
}
print(dp[0][n-1])