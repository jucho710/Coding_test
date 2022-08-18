// https://www.acmicpc.net/source/37552801

//2933번 미네랄
//입력
let t = readLine()!.split(separator: " ").map{Int(String($0))!}
var (r,c) = (t[0],t[1])
var graph = [[Bool]]()

// debugGraph
func debugGraph() {
    graph.forEach{
        print($0.map{$0 ? "x" : "."})
    }
}

//고립되어 있는지 확인
func isIsolated(_ x: Int, _ y: Int) -> Bool {
    //탐색안해도 되면 return
    guard (0..<r).contains(x) && (0..<c).contains(y) && graph[x][y] else {
        return false
    }
    
    //dfs탐색 시작
    var visit = Array(repeating: Array(repeating: false, count: c), count: r)
    var stack = [(x,y)]
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    while !stack.isEmpty {
        let (cx,cy) = stack.removeLast()
        if cx == r-1 {
            //print("땅에 닿아있으니, 중력영향 받지 않습니다")
            return false
        }
        if !visit[cx][cy] {
            visit[cx][cy] = true
            for i in 0..<4 {
                let (nx,ny) = (cx+dx[i],cy+dy[i])
                if (0..<r).contains(nx) && (0..<c).contains(ny) && !visit[nx][ny] && graph[nx][ny] {
                    stack.append((nx,ny))
                }
            }
        }
    }
    
    //고립된 미네랄만 뽑습니다
    var target = [(Int,Int)]()
    for (idx, arr) in visit.enumerated() {
        for (jdx,value) in arr.enumerated() where value {
            graph[idx][jdx] = false
            target.append((idx,jdx))
        }
    }
    
    //move만큼 이동할 수 있는지 체크
    for move in 1...100 {
        //move만큼 내림
        let newTarget = target.map{($0.0+move, $0.1)}
        
        //범위안인지, 다른 미네랄과 안겹치는지 검사
        var canMove = true
        newTarget.forEach{
            if (0..<r).contains($0.0) && (0..<c).contains($0.1) && !graph[$0.0][$0.1] {
                
            } else {
                canMove = false
            }
        }
        
        //더이상 이동할 수 없다면, 이전 move만큼 이동할 수 있다는 말
        if !canMove {
            let cnt = move - 1
            
            target.forEach{
                graph[$0.0+cnt][$0.1] = true
            }
            break
        }
    }
    return true
}


//미네랄 재조정
func downMineral() {}

for _ in 0..<r {
    let input = Array(readLine()!).map{ $0 == "." ? false : true}
    graph.append(input)
}

let n = Int(readLine()!)!
let heightList = readLine()!.split(separator: " ").map{Int(String($0))!}

var leftTurn = true

for height in heightList {
    //높이 height의 막대기를 던져서 미네랄 하나 제거
    if leftTurn {
        if let idx = graph[r-height].firstIndex(of: true) {
            graph[r-height][idx] = false
            
            //삭제한 미네랄 기준 상하좌우 네방향 탐색 시작
            let x = r-height, y = idx
            let start = [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]
            for (cx,cy) in start {
                if isIsolated(cx, cy) {
                    //print("isolated left")
                }
            }
        }
        
    } else {
        if let idx = graph[r-height].lastIndex(of: true) {
            graph[r-height][idx] = false
            
            let x = r-height, y = idx
            let start = [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]
            
            for (cx,cy) in start {
                if isIsolated(cx,cy) {
                    //print("isolated right")
                }
            }
        }
    }
    leftTurn.toggle()
}

for g in graph {
    print(g.map{$0 ? "x" : "."}.joined(separator: ""))
}