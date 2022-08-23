// https://www.acmicpc.net/source/34040516

import Foundation


final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}
let f = FileIO()
let N = f.readInt()
var arr = [Int]()
for _ in 0..<N {
  arr.append(f.readInt())
}
var ret = ""
var memo1 = [Int](repeating: 0, count: N)
var memo2 = [Int](repeating: 0, count: N-1)
for i in 0..<N {
  var cnt = 0
  var lo = i
  var hi = i 
  while lo - 1 >= 0 && hi + 1 < N {
    lo -= 1
    hi += 1
    if arr[lo] != arr[hi] {
      break
    }
    cnt += 1
  }
  memo1[i] = cnt
}
for i in 0..<N-1 {
  var cnt = 1
  var lo = i
  var hi = i+1
  if arr[lo] != arr[hi] {
    continue
  }
  while lo - 1 >= 0 && hi + 1 < N {
    lo -= 1
    hi += 1
    if arr[lo] != arr[hi] {
      break
    }
    cnt += 1
  }
  memo2[i] = cnt
}
for _ in 0..<f.readInt() {
  let S = f.readInt()-1, E = f.readInt()-1
  if (E - S) % 2 == 0 {
    ret.write(memo1[(E+S)/2] >= ((E-S)/2) ? "1\n" : "0\n")
  } else {
    ret.write(memo2[(E+S)/2] >= ((E-S)/2+1) ? "1\n" : "0\n")
  }
}
print(ret)