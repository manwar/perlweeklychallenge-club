import sys

if len(sys.argv) < 2:
    bin_str = '010'
else:
    bin_str = sys.argv[1]

size = len(bin_str)
num  = int(bin_str, 2)

res  = []
max  = 0

for left in list(range(0,size)):
    for right in list(range(left,size)):
        bin_int = num
        for number in list(range(left,right+1)):
            bin_int ^= 1 << size - number -1
        
        ones = bin(bin_int).count("1")

        if ones > max:
            max = ones
            res.clear()

        if ones == max:
            res.append([left,right])

print ("Pair of L-R (one's = " + str(max) + "):")
for out in res:
    print (out)

"""
python .\ch-1.py
Pair of L-R (one's = 2):
[0, 0]
[0, 2]
[2, 2]

python .\ch-1.py 0101101101
Pair of L-R (one's = 7):
[0, 0]
[0, 2]
[2, 2]
[5, 5]
[8, 8]
"""
