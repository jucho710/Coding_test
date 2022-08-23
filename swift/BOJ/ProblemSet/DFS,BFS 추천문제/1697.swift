// https://www.acmicpc.net/source/20750276

let nk = readLine()!.split{$0 == " "}.map{Int($0)!}, mx = Int(1e5) + 1
var a = [nk[0]], i = 0, s = Array(repeating: mx, count: mx)
s[nk[0]] = 0
while i < a.count {
	var j = a[i]
	if j == nk[1] {
		print(s[j])
		break
	}
	
	let dist = s[j] + 1
	j += 1
	if j < mx && dist < s[j] {
		s[j] = dist
		a.append(j)
	}
	j -= 2
	if 0 <= j && dist < s[j] {
		s[j] = dist
		a.append(j)
	}
	j = (j + 1) * 2
	if j < mx && dist < s[j] {
		s[j] = dist
		a.append(j)
	}
	i += 1
}
