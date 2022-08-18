// https://www.acmicpc.net/source/29723051

let MOD = 1000000
let N = Int(readLine()!)!
var cache: [Int : Int] = [:]
cache[0] = 0
cache[1] = 1
cache[2] = 1

func f(_ n: Int) -> Int {
    if cache[n] != nil {
        return cache[n]!
    }

    if n % 2 == 0 {
        let k = n / 2
        var sum = 0
        let a = f(k-1) % MOD, b = f(k) % MOD
        sum = (a * 2) % MOD 
        sum += b
        sum %= MOD
        sum *= b
        sum %= MOD
        cache[n] = sum
        return sum
    } else {
        let k = (n+1) / 2
        var sum = 0
        let a = f(k-1) % MOD, b = f(k) % MOD
        sum = (a*a) % MOD
        sum += (b*b) % MOD
        sum %= MOD
        cache[n] = sum
        return sum
    }
}

print(f(N))