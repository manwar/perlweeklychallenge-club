# Is the room open?
#
# There are 500 rooms in a hotel with 500 employees having keys to all the
# rooms. The first employee opened main entrance door of all the rooms. The
# second employee then closed the doors of room numbers 2,4,6,8,10 and so on to
# 500. The third employee then closed the door if it was opened or opened the
# door if it was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the
# fourth employee did the same as the third but only room numbers 4,8,12,16 and
# so on to 500. This goes on until all employees has had a turn.
#
# Write a script to find out all the rooms still open at the end.


# This took me a while to figure out.
#
# 1. Given a single room number N, how many times did an employee open or
# closed the door of that room? Let's look at the k-th employee. The employee
# opens or closes the door of room N if and only if k is a divisor of N. So if
# we want to know how often the door has been opened or closed we must count
# the number of divisors of the room number N.
#
# 2. If room number N has been opened or closed an even number of times the
# door is closed. If the number of divisors of N is an odd number the door is
# open. So this problem is equivalent to finding all N equal or below 500 that
# have an odd number of divisors.
#
# 3. Take the prime decomposition of N:
#
#   N = p1^k1 * p2^k2 * ... * pi^ki.
#
# The number of divisors of N is (k1 + 1) * (k2 + 1) * ... * (ki + 1).
#
# 4. The number of divisors of N is odd if and only if k1, k2, ..., ki, are all
# even. (If kj would be odd, kj + 1 is even, hence every product with kj + 1 is
# even) But if k1, k2, ..., ki are all even, N is a squared number.
#
# 5. Therefore, the only open rooms can be rooms with a squared number below
# 500. This is a (maybe difficult to understand why correct) one-liner.

say "Open rooms:";
say $_**2 for 1..(500.sqrt);
