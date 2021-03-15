#! /opt/local/bin/perl
#
#       puzzlehash.pl
#
#         TASK #2 › Hash-counting String
#         Submitted by: Stuart Little
#         You are given a positive integer $N.
# 
#         Write a script to produce Hash-counting string of that length.
# 
#         The definition of a hash-counting string is as follows:
# 
#         - the string consists only of digits 0-9 and hashes, ‘#’
#         - there are no two consecutive hashes: ‘##’ does not appear in your
#           string
#         - the last character is a hash
#         - the number immediately preceding each hash (if it exists) is the
#           position of that hash in the string, with the position being counted
#           up from 1
#
#         It can be shown that for every positive integer N there is exactly one such length-N string.
# 
#         Examples:
#         (a) "#" is the counting string of length 1
#         (b) "2#" is the counting string of length 2
#         (c) "#3#" is the string of length 3
#         (d) "#3#5#7#10#" is the string of length 10
#         (e) "2#4#6#8#11#14#" is the string of length 14

#         method:
# 
#             ok this one is outright weird. It seems to be simply an analytical
#             puzzle rather than having any practical significance. So rather than
#             research a solution I think I'll just attack it logically and see
#             what happens.
# 
#             1. The last character is a hash, and no two hashes can be placed
#             successively, thus the character before the final hash is a digit,
#             indicating the position of that hash.
# 
#             2. The length of the string is the quantity being "counted" here. I
#             think they kind of buried the lede on that one. No matter, it's
#             still all there in the description.
# 
#             3. Thus the last hash will be in position N, and the number
#             preceeding will be N.
# 
#             4. The character preceeding the number N can be any digit or a hash,
#             but should it be a digit, it would have no significance. As such any
#             digit would do, leading to the ability to construct 10 such stings
#             with the various digits in this place. As we are told the string is
#             unique, this is a contradiction, and thus the next character must be
#             a hash. 

#                 4.1 It is not explicitly defined as to whether all of the digits
#                 perceeding a given hash compose the number defining its position,
#                 for example a string starting with 104#, with only the 4
#                 referencing the hash in the 4th position. In any case this case is
#                 moot considering the previous logic. Alternately should this be
#                 defined as true, that the number should be composed of all possible
#                 digits, then the other argument becomes moot, as the string must by
#                 necessity alternate numbers and hash marks functioning as
#                 separators.
# 
#                 4.2. I believe this line of reasoning is required to deduce the 
#                 uniqueness of one string per length quality
# 
#             5. Generalizing, the string is composed solely of alternating hashes
#             and numbers, with the number preceeding each hash indicating the
#             position of that hash.
# 
#             6. The positions are 1-based, rather than 0-based indexes.
# 
#             So the algorithm is to start at the end of the string, placing a
#             hash in the N-th position, counted starting at 1. We then
#             concatenate the position of that hash to the string and count our
#             length. If it is less than N, add a hash. If it was N-1 we are done,
#             else we need to loop and add the numerical poistion of the
#             last-placed hash to the front of the string. As we approach the
#             front of our string, we are guarenteed that the position indicating
#             numbers will become single-digit, so our last-placed character will
#             either be a hash or a single digit 2 indicating the position of hash
#             following in the second place.
# 
#             What a weird, fun little puzzle.
            
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

for (1..32) {
    say sprintf "%2d -> %s", $_, get_hash_string( $_ );
}

sub get_hash_string ( $num ) {
    my $str = '';
    
    while ( my $pos = $num - length $str )  {
        $str = '#' . $str;
        return $str if $pos == 1;
        $str = $pos . $str;
    }
    
    return $str;
}














# use Test::More;
# 
# is 
# 
# done_testing();
