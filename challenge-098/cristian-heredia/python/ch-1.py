'''

TASK #1 › Read N-characters
Submitted by: Mohammad S Anwar
You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and moves the pointer to the (n+1)th character.

Example:
    Input: Suppose the file (input.txt) contains "1234567890"
    Output:
        print readN("input.txt", 4); # returns "1234"
        print readN("input.txt", 4); # returns "5678"
        print readN("input.txt", 4); # returns "90"

'''

import os

number = 4
text = 1234567890 

#Returns the first n-characters and moves the pointer to the (n+1)th character
def readN(fileName, N):
    #The file is opened and copy its content in the variable "contents"
    with open (fileName, 'rt') as myfile:  
        contents = myfile.read()  
    #Read the file's content and groups the characters n by n
    for line in ([contents[i:i+N] for i in range(0, len(contents), N)]):
        print("print readN(\"{}\", {}); # returns \"{}\"".format(fileName, N, line))

#Request the name of the file to the user
def askFileName():
    file_name = input("Please, introduce the name of the file\n")

    #We check that the file exists, if not, the file is created with a specific text
    if (os.path.isfile(file_name) == False):
        f = open(file_name, 'w')
        f.write(str(text))
        f.close()
    readN(file_name, number)

#Request the name of the file to the user
askFileName()
   