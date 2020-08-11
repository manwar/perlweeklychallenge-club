#!/usr/bin/env perl6
use v6;

# Problem:
#   Write a script to print all possible series of 3 positive numbers,
#   where in each series at least one of the numbers is even and the sum
#   of the three numbers is always 12. For example, (3, 4, 5)
#
# This description uses the term "series" but does not seem to use this
# word in a typical mathematical way.  I am assuming that what is being
# asked for is actually *sets* of numbers, where the following is true:
#
#   Being a set, no ordering is implied.  Thus 1,2,3 is the same as 3,2,1,
#   and thus it should only be output once.
#
#   Being a set, no duplicates are allowed.  I.E. 4,4,4 is not valid.
#
#   Because positive numbers are defined, zero is not valid.
#
#   I'm assuming only integers are being requested, even though that is
#   not explictly stated.  Otherwise this would be an infinite sequence.
#
#   Because we must have 3 numbers which are ≥ 1, and we know 1+2+3 (the
#   smallest 3 numbers that are ≥ 1) is not 12, we can assume n+1+2
#   might equal 12 for some n > 2, and this would be the largest value
#   that could be added to any other two positive integers that add up
#   to 12.  I.E. 12-3 = 9, so 1+2+9 = 12, so we know the set must not
#   contain numbers that are not between (inclusively) 1 and 9.
#
#   Finally, we are told at least one of the numbers is even.  This
#   means no more than 2 numbers are odd.  We know from number theory,
#   that adding 3 positive, odd numbers would produce an odd number
#   (I.E. two positive, odd numbers added always produces an even number,
#   and if that even number was added with an odd number, the result
#   would be odd - since 12 is definitely not odd, we know that three
#   positive, odd numbers are not a possibility).
#

# We will do this with a pipeline.

cross((1..9) xx 3)\             # Create a list where each element is a list of
                                #   3 numbers inclusively between 1 and 9.
    ».Set                       # Turn those elements into sets
    .grep( *.elems == 3 )       # Sets flatten duplicates, so we want to be sure
                                #   there are still 3 elements in the set.
    .unique                     # We will have duplicate sets, remove the dupes
    .map( *.keys.list )         # Turn the list back into a list
    .grep( *.sum == 12 )        # Do the set members add to 12?
    .map( *.sort )              # Sort the numbers in each set
    .map( *.join(",") )         # Make the sets into comma-deliminated strings
    .sort                       # Sort the sets of numbers
    .join("\n")                 # Build a string, seperating sets by newlines
    .say
