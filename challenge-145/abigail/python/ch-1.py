#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

a = [int (x) for x in input () . split (" ")]
b = [int (x) for x in input () . split (" ")]

sum = 0
for i in range (len (a)):
    sum = sum + a [i] * b [i]

print (sum)
