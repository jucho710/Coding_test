// https://www.acmicpc.net/source/25239891

let N  = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<N {
    let qq = readLine()!.split(separator : " ").map{Int(String($0))!}
    arr.append(qq)
}
var visit = Array(repeating:false,count:N)
var answer = Int.max

func dfs(_ cur : Int, _ count : Int , _ sum : Int, _ start : Int   ) {
    if sum >= answer { return }
    
    if count == N {
        if arr[cur][start] == 0 { return }
        answer = min(answer,sum+arr[cur][start])
        return
    }
    
    for i in 0..<N {
        if visit[i] { continue }
        if arr[cur][i] == 0 { continue }
        visit[i] = true
        
        dfs(i, count+1, arr[cur][i]+sum,start)
        visit[i] = false
    }
    
}
visit[0] = true
dfs(0, 1, 0,0)
print(answer)
