from sys import argv

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070/

s, c, o = argv[1:4]
S = list(s)
c = int(c)
o = int(o)
n = len(s)

for i in range(1, c+1):
    S[i%n], S[(i+o)%n] = S[(i+o)%n], S[i%n]

s = "".join(S)
print(s)
