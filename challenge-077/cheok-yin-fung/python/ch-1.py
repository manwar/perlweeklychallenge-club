# Python3
# The Weekly Challenge - Perl & Raku
# #077 Task 1 Fibonacci Sum, Python script 

def is_it_new_discovery(newsum):
    global count
    global ans
    if not(newsum in ans):
        ans.append(newsum)
        count = count + 1

def fibsum():
    global count
    global ans
    while count > 0:
        count = 0
        oldlist = ans.copy()
        for i in range( len(oldlist) ):
            for p in range( len(oldlist[i]) ):
                expand( p, oldlist[i] )


def expand( index , a_list):
    if index < len(a_list)-1:
        if a_list[index] - a_list[index+1] >= 3:
            newlist = []
            for i in range(0,index):
                newlist.append(a_list[i])
            newlist.append(a_list[index]-1)
            newlist.append(a_list[index]-2)
            for i in range(index+1,len(a_list)):
                newlist.append(a_list[i])
            is_it_new_discovery(newlist)
    else:
        if index == len(a_list)-1 and a_list[index] >= 3:
            newlist = []
            for i in range(0,index-1):
                newlist.append(a_list[i])
            newlist.append(a_list[index]-1)
            newlist.append(a_list[index]-2)
            is_it_new_discovery(newlist)

def fibnumlist(a_list):
    return list(map( lambda x: fib[x], a_list))

if __name__ == "__main__":
    N = int(input("Enter the number you are concerning with:\n"))

    ans = []

    count = 1

    fundsum = []
    fib = []
    fib.append(1)
    fib.append(1)
    k = 1;
    while N > fib[k]:
        k = k+1
        fib.append(fib[k-1] + fib[k-2])
    if N == fib[k]:
        r = k
    else:
        r = k-1
    
    target = N
    while target != 0:
        if target >= fib[r]:
            target = target - fib[r]
            fundsum.append(r)
        r = r-1

    ans.append(fundsum)
    fibsum()
    for a_list in ans:
        print(fibnumlist(a_list))
    print("number of solution(s): ", len(ans))
