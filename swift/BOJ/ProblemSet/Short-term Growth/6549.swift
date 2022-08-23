// https://www.acmicpc.net/source/31406033

import Foundation

var bytes: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], byteIdx = 0

func readByte() -> UInt8 {
    defer { byteIdx += 1 }
    return bytes.withUnsafeBufferPointer { $0[byteIdx] }
}

func readInt() -> Int {
    var number = 0, byte = readByte(), isNegative = false
    while byte == 10 || byte == 32 { byte = readByte() }
    if byte == 45 { byte = readByte(); isNegative = true }
    while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
    return number * (isNegative ? -1 : 1)
}

func write(_ output: String) {
    FileHandle.standardOutput.write(output.data(using: .utf8)!)
}

var output = ""
var numberArray: [Int] = []
var N = 0
func solve() -> Bool {
    N = readInt()

    if N == 0 {
        return false
    }

    numberArray.removeAll()
    (1...N).forEach { _ in numberArray.append(readInt()) }
    var st: SegmentTree = .init(N)

    struct SegmentTree {
        var nodes: [Int]
        var log: Int
        var size: Int
        var offset: Int
        var e = -1;

        init(_ n: Int) {
            var cnt = n, pow = 0

            while cnt != 0 {
                cnt = cnt >> 1
                pow += 1
            }

            if n == (n & -n) && n != 1 {
                pow -= 1
            }

            offset = 1 << pow
            size = offset * 2
            log = pow
            nodes = Array(repeating: e, count: size)
            nodes[0] = -1

            for i in 0..<n {
                nodes[offset + i] = i
            }

            for i in stride(from: offset-1, to: 0, by: -1) {
                update(i)
            }
        }

        func op(_ a: Int, _ b: Int) -> Int {
            if a == -1 && b != -1 {
                return b
            }

            if b == -1 {
                return a
            }

            if numberArray[a] <= numberArray[b] {
                return a
            }
            return b
        }

        mutating func set(_ idx: Int, _ element: Int) {
            let realIdx = offset + idx
            nodes[realIdx] = element

            for i in 1...log {
                update(realIdx >> i)
            }
        }

        mutating func query(_ left: Int, _ right: Int) -> Int {
            var sml = e, smr = e
            var rl = offset + left, rr = offset + right

            while rl < rr {
                if rl & 1 == 1 {
                    sml = op(sml, nodes[rl])
                    rl += 1
                }
                if rr & 1 == 1 {
                    rr -= 1
                    smr = op(smr, nodes[rr])
                }
                rl >>= 1
                rr >>= 1
            }

            return op(sml, smr)
        }

        mutating func update(_ idx: Int) {
            nodes[idx] = op(nodes[2 * idx], nodes[2 * idx + 1])
        }
    }

    var ans = 0
    func dfs(_ left: Int, _ right: Int) {
        let minIdx = st.query(left, right)
        ans = max(ans, (right - left) * numberArray[minIdx])

        if left < minIdx {
            dfs(left, minIdx)
        }

        if minIdx < right - 1 {
            dfs(minIdx + 1, right)
        }
    }

    dfs(0, N)
    output += "\(ans)\n"

    return true
}

while solve() {}
write(output)