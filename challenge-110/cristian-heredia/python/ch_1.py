'''
    Task #1 › Valid Phone Numbers
    Submitted by: Mohammad S Anwar
    You are given a text file.
    
    Write a script to display all valid phone numbers in the given text file.
    
    Acceptable Phone Number Formats
        +nn  nnnnnnnnnn
        (nn) nnnnnnnnnn
        nnnn nnnnnnnnnn
    
    Input File
        0044 1148820341
        +44 1148820341
        44-11-4882-0341
        (44) 1148820341
        00 1148820341
    Output
        0044 1148820341
        +44 1148820341
        (44) 1148820341
'''

import re
import os

#Variables
text = """
0044 1148820341
+44 1148820341
44-11-4882-0341
(44) 1148820341
00 1148820341
"""

def askFileName():
    file_name = input("Please, introduce the name of the file\n")

    #We check that the file exists, if not, the file is created with a specific text
    if (os.path.isfile(file_name) == False):
        f = open(file_name, 'w')
        f.write(str(text))
        f.close()
    print ("Output:")
    readTelf(file_name)

def readTelf(file_name):
    with open(file_name, 'r') as my_file:
        for row in my_file:
            if (re.match(r"\+\d{2}\s\d{10}", row)) or (re.match(r"\(\d{2}\)\s\d{10}", row)) or (re.match(r"\d{4}\s\d{10}", row)):
                print(row,end="")

askFileName()