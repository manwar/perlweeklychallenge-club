' Challenge 002
'
' Challenge #1
' Write a script or one-liner to remove leading zeros from positive numbers.

dim num as string
num = command(1)
do while len(num)>1 and left(num,1)="0"
    num = mid(num,2)
loop
print num
