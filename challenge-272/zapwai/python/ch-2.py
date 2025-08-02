def proc(str):
    chars = list(str)
    num = []
    for c in chars:
        num.append(ord(c))
    sum = 0
    for i in range(len(num) - 1):
        sum += abs(num[i] - num[i + 1]) 
    print("Input:", str)
    print("Output:", sum)

str = "hello"
proc(str)
str = "perl"
proc(str)
str = "raku"
proc(str)

