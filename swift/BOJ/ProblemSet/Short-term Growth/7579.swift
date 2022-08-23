// https://www.acmicpc.net/source/27444484

let nm = readLine()!.split(separator: " ").map{Int($0)!}
let n = nm[0], m = nm[1]
let byte = readLine()!.split(separator: " ").map{Int(String($0))!}
let cost = readLine()!.split(separator: " ").map{Int(String($0))!}
var dp = Array(repeating: 0, count: 10001)
var result = 10001
for i in 0..<n {
    var tmp = dp
    for j in 0...10000 where j >= cost[i] {
        tmp[j] = max(dp[j], dp[j-cost[i]] + byte[i])
        if tmp[j] >= m {
            result = min(result, j)
        }
    }
    dp = tmp
}
print(result)