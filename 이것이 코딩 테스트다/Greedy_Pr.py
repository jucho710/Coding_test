# Chapter 11. 그리디 문제

# 01 모험가 길드

n = int(input())
lst = list(map(int, input().split()))
lst.sort()

count = 0   # 현재 그룹에 포함된 모험가의 수
result = 0  # 그룹 수
 
# # 작은 공포도부터 인원 충족 요건 만족하는 애들 그룹 만들기만 하고 count?

# for i in lst :
#     if lst.count(i) >= i :
#         count += 1
#         lst.remove(i)

# print(count)

for i in lst :
    count += 1          # 현재 그룹에 해당 모험가 포함
    if count >= i :     # 현재 그룹 포함된 모험가의 수가 현재의 공포도 이상이면, 그룹 결성
        result += 1     # 총 그룹 수 증가
        count = 0       # 현재 그룹 포함된 모험가의 수 초기화

print(result)


# 02 곱하기 혹은 더하기

s = input()
t = 0

for i in s :
    i = int(i)
    if i <= 1 or t <= 1:
        t += i
    else :
        t *= i

print(t)


# 03 문자열 뒤집기

s = input()

# 모두 0으로 변환했을 떄와 모두 1로 변환했을 떄를 따로 고려하여 최소값
count0 = 0
count1 = 0

if s[0] == '1' :
    count0 += 1
else : 
    count1 += 1

for i in range(0, len(s)-1) :
    if s[i] != s[i+1] :
        if s[i+1] == '1' :
            count0 += 1
        else :
            count1 += 1

print(min(count0, count1))


# 04 만들 수 없는 금액

n = int(input())
lst = list(map(int, input().split()))
lst.sort()
target = 1

for i in lst :
    if target < i :
        break
    target += i

print(target)

# 각 동전의 수가 한정되어 있음
# 1 2 3이 주어졌을 때 6(=1+2+3)을 만들 수 있으면 1-5도 만들 수 있음 (1, 2, 3, 1+3, 2+3, 1+2+3)
# 이게 어떻게 성립하지?? 이해 필요


# 05 볼링공 고르기

n, m = map(int,input().split())
k = list(map(int, input().split()))
count = 0

for i in range(n) :
    for j in range(i, n) :
        if k[i] != k[j] :
            count += 1
        else :
            continue

print(count)

# 풀이

n, m = map(int,input().split())
k = list(map(int, input().split()))

# 1부터 10까지의 무게를 담을 수 있는 리스트
array = [0] * 11

for i in k :
    # 각 무게에 해당하는 볼링공의 개수 카운트
    array[i] += 1

result = 0
# 1부터 m까지의 각 무게에 대하여 처리
for i in range(1, m+1) :
    n -= array[i] # 무게가 i인 볼링공의 개수(A가 선택할 수 있는 개수) 제외 -> B가 선택할 수 있는 개수
    result += array[i] * n # A가 선택할 수 있는 개수 * B가 선택할 수 있는 개수

print(result)

# 조합이기 때문에 n은 단계가 진행됨에 따라 줄어듬


# 06 무지의 먹방 라이브

