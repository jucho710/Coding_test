// https://www.acmicpc.net/source/12300500

extension Int{
    func pow(_ p: Int) -> Int{
        let array = (1...p).map { _ in self } //3.pow(10) == 3^10
        return array.reduce(1, * )
    }
}
extension String{
    func next(_ p: Int) -> String{
        let array = self
            .map { String($0) }
            .map { Int($0)! }
            .map { $0.pow(p) }
        return String(array.reduce(0, +))
    }
}

let read = readLine()!.split(separator: " ").map{ String($0) }
var A = read[0], P = Int(read[1])!

var seen = [String: Int]()

while seen[A] != 3 {
    seen[A] = (seen[A] ?? 0) + 1
    A = A.next(P)
}

let once = seen.filter { $0.value == 1}
print(once.count)