// https://www.acmicpc.net/source/47136969

import Foundation

struct PQ<T> {
    var nodes = [T]()
    let sort: (T, T) -> Bool
    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    var count: Int {
        return nodes.count
    }
    func peek() -> T? {
        return nodes.first
    }
    func leftChild(of parentIndex: Int) -> Int {
        return parentIndex * 2 + 1
    }
    func rightChild(of parentIndex: Int) -> Int {
        return parentIndex * 2 + 2
    }
    func parentIndex(of child: Int) -> Int {
        return (child - 1) / 2
    }
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        nodes.swapAt(0, count-1)
        defer {
            shiftDown(from: 0)
        }
        return nodes.removeLast()
    }
    mutating func shiftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChild(of: parent)
            let right = rightChild(of: parent)
            var candidate = parent
            if left < count && sort(nodes[left], nodes[candidate]) {
                candidate = left
            }
            if right < count && sort(nodes[right], nodes[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            nodes.swapAt(parent, candidate)
            parent = candidate
        }
    }
    mutating func push(_ element: T) {
        nodes.append(element)
        shiftUp(from: count-1)
    }
    mutating func shiftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)
        while child > 0 && sort(nodes[child], nodes[parent]) {
            nodes.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }
}

let INF = Int.max
let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]
var row = 0
var col = 0
var nodes = [[String]]()

let T = Int(String(readLine()!))!
for _ in 0..<T {
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    (row, col) = (input[0], input[1])
    nodes = Array(repeating: [String](), count: row+2)
    var prisoners = [(Int, Int)]()
    let blank = Array(repeating: ".", count: col+2)
    nodes[0] = blank
    nodes[nodes.count-1] = blank
    for i in 1..<row+1 {
        let line = ["."] + Array(readLine()!) + ["."]
        for j in 0..<col+2 {
            if line[j] == "$" {
                prisoners.append((i, j))
            }
        }
        nodes[i] = line.map{String($0)}
    }
    
    let (firstRow, firstCol) = (prisoners[0].0, prisoners[0].1)
    let (secondRow, secondCol) = (prisoners[1].0, prisoners[1].1)
    let firstDistances = Dijkstra(startRow: firstRow, startCol: firstCol)
    let secondDistances = Dijkstra(startRow: secondRow, startCol: secondCol)
    let thirdDistances = Dijkstra(startRow: 0, startCol: 0)
    
    var answer = INF
    for i in 0..<row+2 {
        for j in 0..<col+2 {
            if nodes[i][j] == "*" {
                continue
            }
            let firstDistance = firstDistances[i][j]
            let secondDistance = secondDistances[i][j]
            let thirdDistance = thirdDistances[i][j]
            
            if firstDistance == INF || secondDistance == INF || thirdDistance == INF {
                continue
            }
            
            var curCost = firstDistance + secondDistance + thirdDistance
            if nodes[i][j] == "#" {
                curCost -= 2
            }
            answer = min(answer, curCost)
        }
    }
    print(answer)
}

func Dijkstra(startRow: Int, startCol: Int) -> [[Int]] {
    var distances = Array(repeating: Array(repeating: INF, count: col+2), count: row+2)
    distances[startRow][startCol] = 0
    var pq = PQ<(Int, Int, Int)>(sort: {$0.0 < $1.0})
    pq.push((0, startRow, startCol))
    
    while !pq.isEmpty {
        guard let curData = pq.pop() else { break }
        let curCost = curData.0
        let curRow = curData.1
        let curCol = curData.2
        
        if distances[curRow][curCol] < curCost {
            continue
        }
        
        for i in 0..<4 {
            let nextRow = curRow + dy[i]
            let nextCol = curCol + dx[i]
            
            if nextRow < 0 || nextCol < 0 || nextRow >= row+2 || nextCol >= col+2 {
                continue
            }
            
            var nextCost = 0
            if nodes[nextRow][nextCol] == "#" {
                nextCost += 1
            } else if nodes[nextRow][nextCol] == "*" {
                continue
            }
            let totalCost = curCost + nextCost
            
            if distances[nextRow][nextCol] > totalCost {
                distances[nextRow][nextCol] = totalCost
                pq.push((totalCost, nextRow, nextCol))
            }
        }
    }
    return distances
}
