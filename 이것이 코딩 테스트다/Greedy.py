# Chpater 03. 그리디

# 거스름돈
n = 1260
coin_type = [500, 100, 50, 10]
count = 0

for coin in coin_type :
    count += n // coin
    n %= coin

print(count)


# 실전 문제

# 큰 수의 법칙

N, M, K = map(int, input().split())
nlist = list(map(int, input().split()))
t = 0

nlist.sort()
while M != 0 :
    for i in range(K) :
        t += nlist[N-1]
        M -= 1
    t += nlist[N-2]
    M -= 1

print(t)    

# 다른 풀이

N, M, K = map(int, input().split())
nlist = list(map(int, input().split()))
t = 0
nlist.sort()

# 반복되는 수열 길이 : K + 1
# 가장 큰 수가 더해지는 횟수 : M // (K + 1) * K + M % (K + 1)
# 두 번째로 큰 수가 더해지는 횟수 : M // (K + 1) -> M - (가장 큰 수가 더해지는 횟수)

t = nlist[-1] * (M // (K + 1) * K + M % (K + 1)) + nlist[-2] * (M // (K + 1))
print(t)


# 숫자 카드 게임

n, m = map(int, input().split())
lst = []

for i in range(n) :
    lst.append(list(map(int, input().split())))

maxItem = 0
for item in lst :
    if min(item) > maxItem :
        maxItem = min(item)

print(maxItem)


# 1이 될 때까지

n, k = map(int,input().split())
count = 0

while True :
    if n == 1 :
        break

    if n % k == 0 :
        n /= k
        count += 1
        if n == 1 :
            break
    else :
        n -= 1
        count += 1

print(count)