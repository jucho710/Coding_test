//MARK: - 2022-08-23

readLine()
split(separator: " ")
map { Int($0)! }
// readLine()!.split(separator: " ").map { Int($0)! }

Array(repeating: [Int](), count: 4)
print(message, terminator: " ")
array.removeLast()
array.forEach { print($0, terminator: " ") }

let array = (1...p).map { _ in self }
array.reduce(1, * )
// reduce(1, *) : (((((1*array[0])*array[1])*array[2])*array[3])*array[4]) …
// reduce(0, +) : (((((0+array[0])+array[1])+array[2])+array[3])+array[4]) …
// 재귀적으로 호출

let once = seen.filter { $0.value == 1}
