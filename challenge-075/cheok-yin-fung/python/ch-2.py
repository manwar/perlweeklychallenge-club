# Python3
# Perl Weekly Challenge #075 Task 2 Largest Rectangle Histogram , Python script

# A = [3, 2, 3, 5, 7, 5]
# A = [2, 1, 4, 3, 5, 7]
# A = [1, 2, 3, 4, 5]


length = int(input("Enter number of items of the histogram: \n"))
print("Enter items of the histogram with line breaks")
A = []
for i in range(length):  
    A.append(int(input()))

MAX_ = max(A)
#length = len(A)

def subtract1(n):
    if n > 0:
        r = n-1
    else:
        r = 0
    return r

temp = A
temp.append(0)  # put a zero at the end for ease

histogram = []
pair = []
areas = []

for i in range(MAX_):
    histogram.append(temp)
    temp = list(map(subtract1, temp))

histogram = histogram[::-1]



for i in range(MAX_):
    j = 0
    while j < length:
        if histogram[i][j] != 0:
            h = j
            k = j
            while True:
                t = k
                j = j+1
                k = k+1
                if histogram[i][k] == 0:
                    break
            if not([h,t] in pair):
                areas.append( (t-h+1)*(MAX_-i) )
                pair.append([h,t])
        j = j+1
    histogram[i].pop(-1)   #pop out the assisting zero


print("Answer:")
print(max(areas))
print()

def zeroornumsign(x):
    if x > 0:
        return "#"
    else:
        return " "

def print_A():
    for i in range( MAX_ ):
        print(MAX_-i, end=' ')
        templine = list(map(zeroornumsign, histogram[i]));
        for j in range(length):
            print(templine[j], end=' ')        
        print()
    print('  ', end='')
    print("_ " * length)
    print('  ', end='')
    for i in range(length):
        print(str(A[i]), end=' ')
    print()

print_A();

#references:
#https://www.csestack.org/unique-elements-from-list-in-python/
#https://coderwall.com/p/q_rd1q/emulate-do-while-loop-in-python
#https://coderwall.com/p/uhskuq/reverse-array-in-python
