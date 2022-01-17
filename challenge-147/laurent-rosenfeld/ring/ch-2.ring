max = 3000
pentanums = []
for i = 1 to max
    add (pentanums,  i * (3 * i - 1) / 2)
next
// see pentanums + nl
penta_h = []
for i = 1 to max
    penta_h[ string(pentanums[i])] = i
next
for i = 1 to max
    for j = i+1 to max
        diff = pentanums[j] - pentanums[i]
        diff_s = string(diff)
        if isnull(penta_h[diff_s]) loop ok
        sum = pentanums[i] + pentanums[j]
        sum_s = string(sum)
        if isnull(penta_h[sum_s]) loop ok
        see "" + diff + " " + sum + " " + pentanums[i] + " " + pentanums[j] + nl
    next
next
