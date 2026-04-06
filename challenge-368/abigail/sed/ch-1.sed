#!/opt/homebrew/bin/gsed

#
# Run as gsed -rf ch-1.sed < input
#

#
# Strip of the digit. Jump to the appropriate handler.
#
s/ 1$//; tl1
s/ 2$//; tl2
s/ 3$//; tl3
s/ 4$//; tl4
s/ 5$//; tl5
s/ 6$//; tl6
s/ 7$//; tl7
s/ 8$//; tl8
s/ 9$//; tl9

#
# Handlers for each digit
#
:l1; s/1([2-9])/\1/; t; s/(.*)1/\1/; b  # Handle digit == 1
:l2; s/2([3-9])/\1/; t; s/(.*)2/\1/; b  # Handle digit == 2
:l3; s/3([4-9])/\1/; t; s/(.*)3/\1/; b  # Handle digit == 3
:l4; s/4([5-9])/\1/; t; s/(.*)4/\1/; b  # Handle digit == 4
:l5; s/5([6-9])/\1/; t; s/(.*)5/\1/; b  # Handle digit == 5
:l6; s/6([7-9])/\1/; t; s/(.*)6/\1/; b  # Handle digit == 6
:l7; s/7([8-9])/\1/; t; s/(.*)7/\1/; b  # Handle digit == 7
:l8; s/8([9-9])/\1/; t; s/(.*)8/\1/; b  # Handle digit == 8
:l9;                    s/(.*)9/\1/; b  # Handle digit == 9
