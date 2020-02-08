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
# This last pair contains the same number twice. 
# And that is what makes the total number of divisors odd
# And that is what tells us the door 16 will be open.
#
# Knowing all that we can solve by 

say "Open rooms: \n", (1..^500).grep({ .&is-open }) .join(", ");

sub is-open( $room )
{
    my $sqrt = $room.sqrt;
    $sqrt == $sqrt.Int
}

# Open rooms: 1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,441,484