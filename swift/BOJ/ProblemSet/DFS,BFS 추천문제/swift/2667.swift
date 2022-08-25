// https://www.acmicpc.net/source/8619011

var N = Int(readLine()!)!
var graph = Array(repeatElement(Array<Int>(), count: N))
var visit = Array(repeatElement(Array<Int>(), count: N))

for i in 0..<N{
    graph[i] = readLine()!.map({Int(String($0))!})
    visit[i] = Array(repeatElement(0, count: N))
}
var dy = [0,0,1,-1]
var dx = [1,-1,0,0]
func isCan(_ y:Int,_ x:Int) -> Bool{
    return y >= 0 && y < N && x >= 0 && x < N && graph[y][x] == 1
}
var cnt = 0
func dfs(_ y: Int, _ x: Int){
    cnt+=1
    visit[y][x] = 1
    for k in 0..<4{
        let ny = y + dy[k]
        let nx = x + dx[k]
        if isCan(ny,nx) && visit[ny][nx] == 0{
            dfs(ny,nx)
        }
    }
}
var ccn = Array<Int>()
for i in 0..<N{
    for j in 0..<N{
        if(visit[i][j] == 0 && graph[i][j] == 1){
            cnt = 0
            dfs(i,j)
            ccn.append(cnt)
        }
    }
}

ccn.sort()
print(ccn.count)
for element in ccn{
    print(element)
}
