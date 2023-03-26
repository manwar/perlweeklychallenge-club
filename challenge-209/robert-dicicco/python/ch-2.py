#!/usr/bin/env python
'''
-----------------------------------------------------------
AUTHOR: Robert Dicicco
DATE  : 2023-03-26
Challenge 209 Merge Account ( Python )
-----------------------------------------------------------
'''

#accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com", "a1@a.com"]]
accounts = [ ["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com"], ["B", "b2@b.com", "b1@b.com"] ]

a = []
b = []

def unique(list1):
    unique_list = []
    for x in list1:
        if x not in unique_list:
            unique_list.append(x)
    print("\t",unique_list)

print(f"Input: @accounts = {accounts}")
for sub in accounts:

    if sub[0] == "A":
        for x in sub:
            #print(x)
            a.append(x)
    elif sub[0] == "B":
        for x in sub:
            #print(x)
            b.append(x)
print("Output: ")
unique(a)
unique(b)
print(" ")

'''
-----------------------------------------------------------
SAMPLE OUTPUT
python .\MergeAccount.py
Input: @accounts = [['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com', 'a1@a.com']]
Output:
         ['A', 'a1@a.com', 'a2@a.com', 'a3@a.com']
         ['B', 'b1@b.com']

PS G:\Projects\Perl\Challenges> python .\MergeAccount.py
Input: @accounts = [['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com'], ['B', 'b2@b.com', 'b1@b.com']]
Output:
         ['A', 'a1@a.com', 'a2@a.com', 'a3@a.com']
         ['B', 'b1@b.com', 'b2@b.com']
-----------------------------------------------------------
'''


