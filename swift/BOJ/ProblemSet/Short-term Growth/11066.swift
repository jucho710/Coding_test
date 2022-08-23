// https://www.acmicpc.net/source/27394374

var dp:[[Int]] = Array(repeating: Array(repeating: -1, count: 501), count: 501)
var num:[Int] = Array(repeating: -1, count: 501)
let n = Int(readLine()!)!
for _ in 1...n {
    let m = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map{Int(String($0))!}
    var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: m+1), count: m+1)
    var psum:[Int] = Array(repeating: 0, count: m+1)
    var num:[[Int]] = Array(repeating: Array(repeating: 0, count: m+1), count: m+1)
    for i in 1...m {
        psum[i] = psum[i-1] + arr[i-1]
    }
    for i in 1...m {
        num[i-1][i] = i
    }
    for d in 2...m {
        for i in 0...m-d{
            let j = i+d
            dp[i][j] = 3_000_000_000
            for k in num[i][j-1]...num[i+1][j] {
                let tmp = dp[i][k] + dp[k][j] + psum[j] - psum[i]
                if dp[i][j] > tmp {
                    dp[i][j] = tmp
                    num[i][j] = k
                }
            }
        }
    }
    print(dp[0][m])
}