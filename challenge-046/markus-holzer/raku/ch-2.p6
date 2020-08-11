# Each door will only be visited by employees whos number is a divisor
# of the room number. For example room number 12 will be visited
# by the employees 1, 2, 3, 4, 6 and 12. That is 6 visits. As each
# pair of visits cancels itself out, the only rooms that will be open
# at the end are the ones with a number that has an ODD number of divisors.
# From that we can already tell, doors with prime numbers will never be open
# because a prime number always has only 2 divisors.
# 
# Now divisors always come in pairs, in the case of the 12 these are
# (1, 12), (2,6) and (3,4) as each of the pairs multiply out to 12.
#
# In the case of a square number however, there is always one pair for which both elements are the same.
# 16 for example, has the divisor pairs are (1,16), (2, 8) and (4,4). 
# The last (square) pair contains the same number twice. 
# And that is what makes the total number of divisors odd.
# And then that is what tells us the door 16, and all other squares, will be open.
#
# Thus we can know wether a door is open  by checking if the room number is sqare.

say "Open rooms: ", ( 1..500 ).grep: *.&is-open;
sub is-open( $room ) { $room.sqrt.narrow ~~ Int }

# We could also simply generate the list of squares

say "Open rooms: ", (1..500.sqrt.Int).map: * ** 2;

# Or even

say "Open rooms: ", (1..500.sqrt.Int)>>²; # nicest idiom by jnthn