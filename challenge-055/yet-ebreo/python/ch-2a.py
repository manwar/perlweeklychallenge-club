import sys
import time

start_time = time.time()

if len(sys.argv) < 2:
    narray = [1, 2, 3, 4]
else:
    narray = list(map(int, sys.argv[1:])) 

narray.sort()
dict = {}

def wave(a,l,r):
    
    if (l==r):
        flag = 1
        for e in list(range(1,len(a))):
            flag &= (a[e] >= a[e-1], a[e] <= a[e-1])[e % 2 > 0]
            if not flag:
                break

        if flag > 0:
            hold = str(a)
            if (not hold in dict):
                print (hold)
            dict[hold] = 1
    else:
        for i in list(range(l,r+1)):
            a[l],a[i] = a[i],a[l]
            wave(a,l+1,r)
            a[l],a[i] = a[i],a[l]

wave(narray,0,len(narray)-1)
print("Execution Time: %s seconds" % (time.time() - start_time))