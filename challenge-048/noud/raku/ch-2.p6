# Palindrome Dates
#
# Write a script to print all Palindrome Dates between 2000 and 2999. The
# format of date is mmddyyyy. For example, the first one was on October 2, 2001
# as it is represented as 10022001.

# It's possible to compute directly all possibilities. Let
# "m1 m2 d1 d2 y1 y2 y3 y4" be the palindrome, because we look between years 2000
# and 2999, y1 = 2. Because we have a palindrome:
#
#   "m1 m2 d1 d2 2 y2 y3 y4" = "y4 y3 y2 2 d2 d1 m2 m1"
#
# Hence y4 = m1, y3 = m2, y2 = d1, and d2 = 2. The palindrome is of the shape
#
#   "m1 m2 d1 2 2 d1 m2 m1"
#
# The only days possible with d2 = 2 are 02, 12, and 22, hence d1 = 0, 1 or 2.
# For m1 and m2 we have 12 months left.

for 1..12 X ^3 -> ($m, $d) {
    say ($m div 10), ($m % 10), $d, 2, 2, $d, ($m % 10), ($m div 10);
}
