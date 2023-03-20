#!/usr/binenv python
'''
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-14
Challenge 208 Minimum Index Sum ( Python )
------------------------------------------
'''

list1 = [["Perl", "Raku", "Love"],["A","B","C"], ["A", "B", "C"]]
list2 = [["Raku", "Perl", "Hate"],["C","A","B"], ["D", "E", "F"]]

for x in range(0,3):
    set1 = set()
    set2 = set()
    for wds in list1[x]:
        set1.add(wds)

    print("Input: @list1 = ",set1)

    for wds in list2[x]:
        set2.add(wds)

    print("       @list2 = ",set2)

    print('Output: ', sorted(set1 & set2))
    print("\n")

'''
 ------------------------------------------
 SAMPLE OUTPUT
 python .\MinIndexSum.py
Input: @list1 =  {'Raku', 'Perl', 'Love'}
       @list2 =  {'Raku', 'Perl', 'Hate'}
Output:  ['Perl', 'Raku']


Input: @list1 =  {'A', 'B', 'C'}
       @list2 =  {'A', 'C', 'B'}
Output:  ['A', 'B', 'C']


Input: @list1 =  {'A', 'B', 'C'}
       @list2 =  {'D', 'E', 'F'}
Output:  []

 ------------------------------------------
'''


