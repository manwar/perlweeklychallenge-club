def std(a):
    ans = []
    rank = 1
    lvl = a[0]
    for i in range(len(a)):
        if a[i] > lvl:
            rank = i + 1
            lvl = a[i]
        ans.append(rank)
    return ans
    
def mod(a):
    ans = []
    a.reverse()
    lvl = a[0]
    rank = len(a)
    for i in range(len(a)):
        if a[i] < lvl:
            rank = len(a) - i
            lvl = a[i]
        ans.append(rank)
    ans.reverse()
    return ans
    
def den(a):
    ans = []
    rank = 1
    lvl = a[0]
    for i in range(len(a)):
        if a[i] > lvl:
            rank += 1
            lvl = a[i]
        ans.append(rank)
    return ans

def proc(a):
    a.sort()
    print("Input:", a)
    print("Stand:", std(a.copy()))
    print("Modif:", mod(a.copy()))
    print("Dense:", den(a.copy()), "\n")
    
list1 = [1, 2, 2, 3]
list2 = [1, 4, 6, 6, 8, 10, 10]
list3 = [1, 2, 2, 4, 4, 4, 5, 7, 9, 11, 11, 11]
list4 = [3, 3, 6, 6]
for a in [list1, list2, list3, list4]:
    proc(a)
