// https://www.acmicpc.net/problem/12865

import Foundation

let nk = readLine()!.split(separator: " ").map{Int($0)!}
let N = nk[0]
let K = nk[1]

var arr = Array(repeating: 0, count: K+1)
var WV: [(w:Int, v:Int)] = []
for _ in 1...N {
    let line = readLine()!.split(separator: " ").map{Int($0)!}
    WV.append((w:line[0], v:line[1]))
}
for wv in WV {
    let w = wv.w, v = wv.v
    if w > K {continue}
    var temp = arr
    for i in w...K {
        if arr[i] < arr[i-w] + v {
            temp[i] = arr[i-w] + v
        }
    }
    arr = temp
}
print(arr[K])