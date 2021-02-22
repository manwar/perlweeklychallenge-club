'''
TASK #1 › Caesar Cipher
Submitted by: Mohammad S Anwar
You are given string $S containing alphabets A..Z only and a number $N.

Write a script to encrypt the given string $S using Caesar Cipher with left shift of size $N.

    Example
        Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
        Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
        
        Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
        Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
        
        Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
        Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

'''
import string
input = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
n = 3

counter = n

alphabets=list(string.ascii_uppercase)
output = "";

cipher = {}

for letter in alphabets:
    if counter == 26:
        counter = 0
    cipher[alphabets[counter]] = letter
    counter += 1
for char in input:
    if char == " ":
        output = output + char
    else:
        output = output + cipher[char]
print (output)
    


