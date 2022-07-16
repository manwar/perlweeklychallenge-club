import bigints

var s = 2.initBigInt
echo s
for i in 1..9:
    s = s * (s - 1) + 1
    echo s
