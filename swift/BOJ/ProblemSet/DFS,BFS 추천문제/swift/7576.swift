// https://www.acmicpc.net/source/16646590

import Foundation

extension String {
    func splitInt() -> [Int] {
        var isNegative = false
        var num = 0
        var result: [Int] = []
        
        let asciiZero = Character("0").asciiValue!
        
        for c in self+" " {
            if c == Character(" ") {
                if isNegative {
                    num *= -1
                }
                
                result.append(num)
                
                num = 0
                isNegative = false
            } else if c == Character("-") {
                isNegative = true
            } else {
                num += Int(c.asciiValue! - asciiZero)
            }
        }
        
        return result
    }
}

func solution(_ box: [[Int]]) -> Int{
    var box = box
    let dx = [1,0,-1,0]
    let dy = [0,1,0,-1]
    
    var queue: [(Int,Int)] = []
    var cursor = 0
    
    var riped = 0
    var total = 0
    var day = 0
    
    for y in box.indices {
        for x in box[y].indices {
            if box[y][x] == 1 {
                queue.append((x,y))
                riped += 1
                total += 1
            } else if box[y][x] == 0 {
                total += 1
            }
        }
    }
    
    while queue.count > cursor {
        day+=1
        
        let c = queue.count - cursor
        
        for _ in 0..<c {
            let current = queue[cursor]
            cursor += 1
            
            for i in 0..<4 {
                let nx = current.0 + dx[i]
                let ny = current.1 + dy[i]
                
                guard nx>=0,nx<box[0].count,ny>=0,ny<box.count else {
                    continue
                }
                
                guard box[ny][nx] == 0 else {
                    continue
                }
                
                box[ny][nx] = 1
                riped += 1
                queue.append((nx,ny))
            }
        }
    }
    
    if riped == total {
        return day - 1
    } else {
        return -1
    }
}

if let mn = readLine()?.split(separator: " ").map({Int($0)!}) {
    let n = mn[1]
    var box: [[Int]] = []
    
    for _ in 0..<n {
        if let arr = readLine()?.splitInt() {
            box.append(arr)
        }
    }
    
    print(solution(box))
}