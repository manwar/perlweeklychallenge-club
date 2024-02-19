#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/#TASK2
#
# Task 2: Reduced Row Echelon
# ===========================
#
# Given a matrix M, check whether the matrix is in reduced row echelon form.
#
# A matrix must have the following properties to be in reduced row echelon form:
#
# 1. If a row does not consist entirely of zeros, then the first
#    nonzero number in the row is a 1. We call this the leading 1.
# 2. If there are any rows that consist entirely of zeros, then
#    they are grouped together at the bottom of the matrix.
# 3. In any two successive rows that do not consist entirely of zeros,
#    the leading 1 in the lower row occurs farther to the right than
#    the leading 1 in the higher row.
# 4. Each column that contains a leading 1 has zeros everywhere else
#    in that column.
#
# For example:
#
# [
#    [1,0,0,1],
#    [0,1,0,2],
#    [0,0,1,3]
# ]
#
# The above matrix is in reduced row echelon form since the first nonzero
# number in each row is a 1, leading 1s in each successive row are farther to
# the right, and above and below each leading 1 there are only zeros.
#
# For more information check out this wikipedia article.
#
## Example 1
##
##     Input: $M = [
##                       [1, 1, 0],
##                       [0, 1, 0],
##                       [0, 0, 0]
##                 ]
## Output: 0
#
## Example 2
##
##     Input: $M = [
##                       [0, 1,-2, 0, 1],
##                       [0, 0, 0, 1, 3],
##                       [0, 0, 0, 0, 0],
##                       [0, 0, 0, 0, 0]
##                 ]
## Output: 1
#
## Example 3
##
##     Input: $M = [
##                       [1, 0, 0, 4],
##                       [0, 1, 0, 7],
##                       [0, 0, 1,-1]
##                 ]
## Output: 1
#
## Example 4
##
##     Input: $M = [
##                       [0, 1,-2, 0, 1],
##                       [0, 0, 0, 0, 0],
##                       [0, 0, 0, 1, 3],
##                       [0, 0, 0, 0, 0]
##                 ]
## Output: 0
#
## Example 5
##
##     Input: $M = [
##                       [0, 1, 0],
##                       [1, 0, 0],
##                       [0, 0, 0]
##                 ]
## Output: 0
#
## Example 6
##
##     Input: $M = [
##                       [4, 0, 0, 0],
##                       [0, 1, 0, 7],
##                       [0, 0, 1,-1]
##                 ]
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Check all of the conditions one by one. Return the correct
# result.

def reduced_row_echelon(M: list) -> None:
    # set some variables for better handling
    matrix_rows = M
    rows = len(matrix_rows)
    columns = len(matrix_rows[0])
    # check that all rows are of the same length, otherwise this isn't a matrix
    for i in range(rows):
        if len(matrix_rows[i]) != columns:
            print("Not a matrix: Not all rows have the same number of columns!\n")
            return
    # print the input matrix
    print("Input: [")
    for row in matrix_rows:
        print("         [", ", ".join(str(x) for x in row), "],", sep="")
    print("       ]")
    # initialize a few helper variables
    last_starting_one = -1
    row_num = -1
    found_all_zeroes = False
    # for each row, check all the conditions
    for row in matrix_rows:
        row_num += 1
        # find first non-zero number in row
        first_non_zero = -1
        for i in range(len(row)):
            if row[i] != 0:
                if row[i] == 1:
                    first_non_zero = i
                else:
                    # we found the first non-zero number, but it's != 1
                    # first condition not met
                    print("Output: 0")
                    return
                break
        if first_non_zero == -1:
            # this row consists entirely of zeroes
            found_all_zeroes = True
        if found_all_zeroes and first_non_zero != -1:
            # we found a row with all zeroes before, but now we have a non-zero element in the row
            # condition 2 not met
            print("Output: 0")
            return
        if first_non_zero != -1 and first_non_zero <= last_starting_one:
            # our first non-zero element is before the first non-zero in the previous row
            # condition 3 not met
            print("Output: 0")
            return
        last_starting_one = first_non_zero; # for the next round
        for j in range(len(matrix_rows)):
            if j == row_num:
                continue
            if matrix_rows[j][first_non_zero] != 0 and first_non_zero >= 0:
                # we found a row that has a non-zero value in the column that matches
                # the first non-zero column in the row we're currently considering
                # condition 4 not met
                print("Output: 0")
                return
    print("Output: 1")

reduced_row_echelon( [ [1, 1, 0], [0, 1, 0], [0, 0, 0] ] );
reduced_row_echelon( [ [0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0] ] );
reduced_row_echelon( [ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1,-1] ] );
reduced_row_echelon( [ [0, 1,-2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0] ] );
reduced_row_echelon( [ [0, 1, 0], [1, 0, 0], [0, 0, 0] ] );
reduced_row_echelon( [ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1] ] );

