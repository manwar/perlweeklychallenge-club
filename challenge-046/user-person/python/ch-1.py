#!/usr/bin/python

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/         #
#                                                                         #
###########################################################################

message1 = """H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o"""

message2 = '''P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \\
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0'''

def decode (message):
    message       = message.replace(" ","")
    rowLength     = message.index('\n')
    decodedString = [None] * rowLength
    seen          = {}

    for i in range(0,rowLength):
        seen.update({ i : {}})
        
    col = 0

    for char in message:
        if char == '\n':
            col = 0
            continue
         
        if char in seen[col]:
            seen[col][char] += 1
            
            if seen[col][char] == 2:
                decodedString[col] = char

        else:
            seen[col].update({char: 1})

        col += 1

    return ''.join(decodedString)

print(decode(message1))
print(decode(message2))

# ch-1.py output:
#                 Hello
#                 PerlRaku
