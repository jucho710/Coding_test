//
//  main.swift
//  BFS_Practice
//
//  Created by 조주은 on 2022/09/21.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let m = input[1]

var map = [[Int]]()

for _ in 0..<n {
    let temp = Array(readLine()!).map { Int(String($0))! }
    map.append(temp)
}

var queue = [(0, 0)]
let (dx, dy) = ([-1, 1, 0, 0], [0, 0, 1, -1])

while !queue.isEmpty {
    let (x, y) = queue.removeFirst()
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        if nx < 0 || ny < 0 || nx >= n || ny >= m { continue }
        if map[nx][ny] == 0 { continue }
        if map[nx][ny] == 1 {
            map[nx][ny] = map[x][y] + 1
            queue.append((nx, ny))
        }
    }
}

print(map[n-1][m-1])
print()
