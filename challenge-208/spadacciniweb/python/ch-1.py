# Task 1: Minimum Index Sum
# Submitted by: Mohammad S Anwar
# 
# You are given two arrays of strings.
# Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.
# 
# Example 1
# Input: @list1 = ("Perl", "Raku", "Love")
#        @list2 = ("Raku", "Perl", "Hate")
# Output: ("Perl", "Raku")
# 
# There are two common strings "Perl" and "Raku".
# Index sum of "Perl": 0 + 1 = 1
# Index sum of "Raku": 1 + 0 = 1
# 
# Example 2
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("D", "E", "F")
# Output: ()
# 
# No common string found, so no result.
# 
# Example 3
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("C", "A", "B")
# Output: ("A")
# 
# There are three common strings "A", "B" and "C".
# Index sum of "A": 0 + 1 = 1
# Index sum of "B": 1 + 2 = 3
# Index sum of "C": 2 + 0 = 2

def get_minimum_index_sum(list1, list2):
    words = set()
    value = None
    for i in range(0, len(list1)):
        for j in range(0, len(list2)):
            if value != None and value < i + j:
                break
            if list1[i] == list2[j]:
                if value == None or value > i+j:
                    words = set()
                    value = i + j
                words.add('"'+list1[i]+'"')
                break
    print("({:s})".format(', '.join(words)))

if __name__ == "__main__":
    get_minimum_index_sum(["Perl", "Raku", "Love"],
                          ["Raku", "Perl", "Hate"]);
    get_minimum_index_sum(["A", "B", "C"],
                          ["D", "E", "F"]
                         );
    get_minimum_index_sum(["A", "B", "C"],
                          ["C", "A", "B"]
                         );
