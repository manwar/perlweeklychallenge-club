# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#
# Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/
#
# Output:
#
# $ python3 ch-1.py 
# 10
# 7
# 6
# 1

data = 9, 10, 7, 5, 6, 1

for i in range(len(data) - 1):
    if data[i] > max(data[i+1:]):
        print(data[i])
print(data[-1])
