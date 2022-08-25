// https://www.acmicpc.net/source/34285794

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let M = input[1]
var map = [[Int]]()
for _ in 0..<N {
  map.append(readLine()!.map { Int($0.asciiValue!) - 65})
}
let dn = [-1, 1, 0, 0]
let dm = [0, 0, -1, 1]
var visited = 1 << map[0][0]
var cache = [[[Int: Int]]](repeating: [[Int: Int]](repeating: [:], count: M), count: N)
func search(n: Int, m: Int) -> Int {
  if let val = cache[n][m][visited] {
    return val
  }
  var temp = 0
  for i in 0..<4 {
    let n2 = n + dn[i]
    let m2 = m + dm[i]
    if (0..<N).contains(n2) && (0..<M).contains(m2) {
      let val = map[n2][m2]
      if !(visited & (1 << val) == 0) {
        continue
      }
      visited |= (1 << val)
      temp = max(temp, search(n: n2, m: m2))
      visited &= ~(1 << val)
    }
  }
  cache[n][m][visited] = temp
  return temp + 1
}
print(search(n: 0, m: 0))