left_fact = 1
fact = 1
for i = 1 to 10
    see " " + left_fact
    fact *= i
    left_fact += fact
next
see " " + nl
