# Task 2: Sort Column
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of strings of same length.
# Write a script to make each column sorted lexicographically by deleting any non sorted columns.
# Return the total columns deleted.
# 
# Example 1
# Input: @list = ("swpc", "tyad", "azbe")
# Output: 2
# 
# swpc
# tyad
# azbe
# 
# Column 1: "s", "t", "a" => non sorted
# Column 2: "w", "y", "z" => sorted
# Column 3: "p", "a", "b" => non sorted
# Column 4: "c", "d", "e" => sorted
# 
# Total columns to delete to make it sorted lexicographically.
# 
# Example 2
# Input: @list = ("cba", "daf", "ghi")
# Output: 1
# 
# Example 3
# Input: @list = ("a", "b", "c")
# Output: 0

def sorted_by_deleting(list):
    columns = []
    for word in list:
        for i in range( len(word) ):
            try:
                columns[i].append( word[i] )
            except IndexError:
                columns.insert(i, [])
                columns[i].append( word[i] )

    unsorted = 0
    for column in columns:
        if ''.join( sorted( column[:]) ) != ''.join( column ):
            unsorted += 1

    print("%s -> %d" % ( " ".join(map("'{}'".format, list )), unsorted) )

if __name__ == "__main__":
    list = ("swpc", "tyad", "azbe")
    sorted_by_deleting(list)

    list = ("cba", "daf", "ghi");
    sorted_by_deleting(list)

    list = ("a", "b", "c");
    sorted_by_deleting(list)
