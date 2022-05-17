n, k = map(int, input().split())
a = list(map(int, input().split()))
b = list(map(int, input().split()))

a = sorted(a)
b = sorted(b)

for i in range(k):
    a[i], b[-(i+1)] = b[-(i+1)], a[i]

result = 0
for n in a:
    result += n

print(a)
print(result)