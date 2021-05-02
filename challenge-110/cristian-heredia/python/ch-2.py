'''
    TASK #2 › Transpose File
    Submitted by: Mohammad S Anwar
    You are given a text file.
    
    Write a script to transpose the contents of the given file.
    
        Input File
            name,age,sex
            Mohammad,45,m
            Joe,20,m
            Julie,35,f
            Cristina,10,f
        Output:
            name,Mohammad,Joe,Julie,Cristina
            age,45,20,35,10
            sex,m,m,f,f
'''

import csv
import sys


with open(sys.argv[1], 'r') as my_file:
    data_CSV = csv.reader(my_file)
    list_CSV = list(data_CSV)
result = map(list, zip(*list_CSV))
for r in result:
    for j in r:
        print(j, end= ', ')
    print()