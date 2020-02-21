# Survivor
#
# There are 50 people standing in a circle in position 1 to 50. The person
# standing at position 1 has a sword. He kills the next person i.e. standing at
# position 2 and pass on the sword to the immediate next i.e. person standing
# at position 3. Now the person at position 3 does the same and it goes on
# until only one survives.
#
# Write a script to find out the survivor.

# This is a special case of the Josephus problem:
#
#   https://en.wikipedia.org/wiki/Josephus_problem
# and
#
#   https://oeis.org/A006257
#
# Let n be the total number of people in the circle and k be the step to the
# next person. I.e. k - 2 people are skipped, person k is killed and person
# k will get the sword. Let f(n, k) denote the position of the survivor. If
# person k is killed, we're left with a circle of n - 1 and the next person who
# gets the sword is (k mod n) + 1. The survivor person in the remaining circle
# is f(n - 1, k) if we start counting at 1. Shifting the numbers the survivor
# person is (f(n - 1, k) + k - 1) mod n + 1. Hence we have the recurrence
# relation:
#
#   f(n, k) = (f(n - 1, k) + k - 1) mod n + 1.
#
# For this problem we have n = 50 and k = 2.

multi sub f(1, $k) { 1; }
multi sub f($n, $k) { (f($n - 1, $k) + $k - 1) % $n + 1; }

say "Survivor: ", f(50, 2);
