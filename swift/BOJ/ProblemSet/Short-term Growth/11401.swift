// https://www.acmicpc.net/source/33833334

let MOD = 1000000007

func pow(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return 1
    }
    if b % 2 > 0 {
        return (pow(a, b - 1) * a) % MOD
    }
    let h = pow(a, b / 2) % MOD
    return (h * h) % MOD
}

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]
var A = 1
var B = 1
var ans = 0

for i in 1...N {
    A *= i
    A %= MOD
}
if K != 0 {
    for i in 1...K {
        B *= i
        B %= MOD
    }
}
if K != N {
    for i in 1...N - K {
        B *= i
        B %= MOD
    }
}
print((A * pow(B, MOD - 2)) % MOD)