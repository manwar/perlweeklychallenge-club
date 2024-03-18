r = ["I", "V", "X", "L", "C", "D", "M"]
v = [1, 5, 10, 50, 100, 500, 1000]
def roman(c):
    for i in range(len(r)):
        if r[i] == c:
            return v[i]

basic = [ "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" ]
modern = [ "IV", "IX", "XL", "XC", "CD", "CM" ]

def convert_from_roman(s):
    print("Input:",s)
    for i in range(len(basic)):
        key = modern[i]
        val = basic[i]
        s = s.replace(key, val)
    sum = 0
    for c in list(s):
        sum += roman(c)
    print("Output:", sum)

def convert_to_roman(num):
    print("Input:", num)
    ans = ""
    stack = []
    for i in range(len(r)):
        if num >= v[i]:
            stack.append(v[i])
    i = len(stack) - 1
    while i >= 0:
        x = stack.pop()
        d = int(num/x)
        for j in range(d):
            ans += r[i]
        num -= d*x
        i -= 1
    for i in range(len(basic)):
        key = basic[len(basic) - 1 - i]
        val = modern[len(basic) - 1 - i]
        ans = ans.replace(key, val)
    print("Output:", ans)

convert_from_roman("CCXLVI")
convert_to_roman(39);

