// https://www.acmicpc.net/source/11617255

if let input = readLine() {
    for _ in 0 ..< (Int(input) ?? 0) {
        if let input = readLine() {
            let n = Int(input) ?? 0
            if let input = readLine() {
                var isRead = Array(repeating: false, count: n)
                let aArr = input.split{ $0 == " " }.map{ Int($0) ?? 0}                
                var res = 0
                for i in 1 ... aArr.count {
                    if isRead[i-1] { continue }
                    let first = aArr[i-1]
                    var next = aArr[first-1]
                    isRead[i-1] = true
                    isRead[first-1] = true
                    while true {
                        if next == first { break }
                        isRead[next-1] = true
                        next = aArr[next-1]
                    }
                    res += 1
                }
                print(res)
            }
        }
    }
}