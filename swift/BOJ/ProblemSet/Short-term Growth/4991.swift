// https://www.acmicpc.net/source/38506604

import Foundation

var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()), byteIdx = 0; buffer.append(0)

@inline(__always) func readByte() -> UInt8 {
    defer { byteIdx += 1 }
    return buffer.withUnsafeBufferPointer { $0[byteIdx] }
}

@inline(__always) func readInt() -> Int {
    var number = 0, byte = readByte(), isNegative = false
    while byte == 10 || byte == 32 { byte = readByte() }
    if byte == 45 { byte = readByte(); isNegative = true }
    while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
    return number * (isNegative ? -1 : 1)
}

@inline(__always) func readCharacter() -> UInt8 {
    var byte = readByte()
    while byte == 10 || byte == 32 { byte = readByte() }
    return byte
}

@inline(__always) func writeByString(_ output: String) {
    FileHandle.standardOutput.write(output.data(using: .utf8)!)
}

class Queue<T> {
    var array: [T] = []
    var dataSize = 0
    var maxSize = 0
    var frontIdx = 0
    var rearIdx = 1
    var isEmpty: Bool {
        return dataSize == 0
    }

    var isFull: Bool {
        return dataSize == maxSize
    }

    var count: Int {
        return dataSize
    }

    var first: T? {
        if isEmpty {
            return nil
        }
        let idx = (frontIdx + 1) % maxSize
        return array[idx]
    }

    init(_ n: Int, _ e: T) {
        array = Array(repeating: e, count: n)
        maxSize = n
    }

    func append(_ element: T) {
        if isFull {
            return
        }
        array[rearIdx] = element
        rearIdx = (rearIdx + 1) % maxSize
        dataSize += 1
    }

    func pop() -> T? {
        let returnValue = self.first
        frontIdx = (frontIdx + 1) % maxSize
        dataSize -= 1
        return returnValue
    }
}

enum Tile: UInt8 {
    case robot = 111
    case empty = 46
    case wall = 120
    case dirty = 42
}

typealias Point = (y: Int, x: Int)

let dy = [0, 1, 0, -1]
let dx = [1, 0, -1, 0]

var output = ""
func solution() -> Bool {
    let (W, H) = (readInt(), readInt())

    if W == 0 && H == 0 {
        return false
    }

    func isValidCoord(_ y: Int, _ x: Int) -> Bool {
        return 0..<H ~= y && 0..<W ~= x
    }

    var board = Array(repeating: Array(repeating: Tile(rawValue: 46)!, count: W), count: H)
    var robot: Point = (-1, -1)
    var dirtyArray = [Point]()
    var distanceCache = Array(repeating: Array(repeating: Array(repeating: Array(repeating: -1, count: W), count: H), count: W), count: H)
    (0..<H).forEach { y in
        (0..<W).forEach { x in
            let input = Tile(rawValue: readCharacter())!

            if input == .dirty {
                dirtyArray.append((y, x))
            }

            if input == .robot {
                robot = (y, x)
            }

            board[y][x] = input
        }
    }

    func bfs(_ sy: Int, _ sx: Int) -> Bool {
        var checkArray = Array(repeating: Array(repeating: false, count: W), count: H)
        checkArray[sy][sx] = true

        let queue = Queue<(y: Int, x: Int, d: Int)>(W * H, (-1, -1, -1))
        queue.append((sy, sx, 0))

        var findCount = 0
        while !queue.isEmpty {
            let (y, x, d) = queue.pop()!

            if y != sy || x != sx {
                if y == robot.y && x == robot.x {
                    distanceCache[sy][sx][y][x] = d
                    findCount += 1
                }

                for (dirtyY, dirtyX) in dirtyArray {
                    if y == dirtyY && x == dirtyX {
                        distanceCache[sy][sx][y][x] = d
                        findCount += 1
                        break
                    }
                }
            }

            for i in 0..<4 {
                let ny = y + dy[i]
                let nx = x + dx[i]

                if !isValidCoord(ny, nx) {
                    continue
                }

                if board[ny][nx] == .wall {
                    continue
                }

                if checkArray[ny][nx] {
                    continue
                }

                checkArray[ny][nx] = true
                queue.append((ny, nx, d + 1))
            }
        }

        return findCount == dirtyArray.count
    }

    if !bfs(robot.y, robot.x) {
        output += "-1\n"
        return true
    }

    for (y, x) in dirtyArray {
        let _ = bfs(y, x)
    }

    func caculateDistance() -> Int {
        var returnValue = 0
        var (cy, cx) = robot
        for (y, x) in dirtyArray {
            returnValue += distanceCache[cy][cx][y][x] 
            (cy, cx) = (y, x)
        }
        return returnValue
    }

    var answer = Int.max
    func permutation(_ left: Int, _ right: Int) {
        if left == right {
            answer = min(answer, caculateDistance())
            return
        }

        for idx in left...right {
            dirtyArray.swapAt(left, idx)
            permutation(left + 1, right)
            dirtyArray.swapAt(left, idx)
        }
    }

    permutation(0, dirtyArray.count - 1)
    output += "\(answer)\n"

    return true
}

while solution() {}
writeByString(output)