let input = readLine()!.split(seperator: " ").map { Int($0)! }
let row = input[0]
let coloumn = input[1]

let map: [[Int]] = []
let visited = Array(repeat: [false * coloumn], count: row)

for _ in 0...row {
    let load = readLine()!
    map.append(load)
}

