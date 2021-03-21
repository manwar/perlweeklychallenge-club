'''

TASK #1 › FUSC Sequence
Submitted by: Mohammad S Anwar
Write a script to generate first 50 members of FUSC Sequence. Please refer to OEIS for more information.

The sequence defined as below:

    fusc(0) = 0
    fusc(1) = 1
    for n > 1:
    when n is even: fusc(n) = fusc(n / 2),
    when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

'''

#Create hash: key (numbers 0-max), value (result fusc)
fusc = {0: 0, 1: 1}
maxi = 50

def sequenceFusc():
    n = 2
    while (n <= maxi):
        #if is even:
        if (n % 2 == 0):
            fusc[n] = fusc[n/2]
        else:
            fusc[n] = fusc[(n-1)/2] + fusc[(n+1)/2]
        n += 1

def printSequence():
    n = 0
    result = ''
    while (n <= maxi):
        result += "{}, ".format(fusc[n])
        n += 1
    result = result[:-2]
    print(result)

sequenceFusc()
printSequence()