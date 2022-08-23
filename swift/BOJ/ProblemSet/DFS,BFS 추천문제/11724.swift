// https://www.acmicpc.net/source/43582744

import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
        return buffer[index]
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let FIO = FileIO()

let N = FIO.readInt() //정점 개수
let M = FIO.readInt() //간선 개수

var arr: [[Int]] = Array(repeating: Array(repeating: 0, count: N+1), count: N+1)
var visit: [Bool] = Array(repeating: false, count: N+1)

for _ in 0..<M {
    let first = FIO.readInt()
    let second = FIO.readInt()
    
    arr[first][second] = 1
    arr[second][first] = 1
}

print(dfs_count())



struct Stack<T> {
    private var stack = [T]()
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

func dfs_count() -> Int {
    var cnt = 0

    var stack = Stack<Int>()
    
    for i in 1...N {
        if !visit[i] {
            stack.push(i)
            visit[i] = true
            
            while (!stack.isEmpty) {
                let temp = stack.pop()
                
                for j in 1...N {
                    if !visit[j] && arr[temp!][j] == 1 {
                        stack.push(j)
                        visit[j] = true
                    }
                 }
            }
            cnt += 1
        }
    }
    
    return cnt
}