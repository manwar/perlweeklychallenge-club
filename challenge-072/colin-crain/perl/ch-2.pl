#! /opt/local/bin/perl
#
#       flippity_floppity.pl
#
#       Usage
#       [colincrain:~/PWC]$  perl flippity_floppity.pl 1 11 flippity_floppity.pl 
#       #! /opt/local/bin/perl
#       #
#       #       flippity_floppity.pl
#       #
#       #       Usage:
#               [colincrain:~/PWC]$  perl flippity_floppity.pl 1 11 flippity_floppity.pl 
#               #! /opt/local/bin/perl
#               #
#               #       flippity_floppity.pl
#               #
#               #       Usage:
#               #       [colincrain:~/PWC]$  perl flippity_floppity.pl 1 11 flippity_floppity.pl 
#               #       #! /opt/local/bin/perl
#               #       #
#               #       #       flippity_floppity.pl
#               #       #
#               #       #       Usage:              

#         TASK #2 › Lines Range
#         Submitted by: Mohammad S Anwar
#         You are given a text file name $file and range $A - $B where $A <= $B.
# 
#         Write a script to display lines range $A and $B in the given file.
# 
#         Example
#         Input:
#             $ cat input.txt
#             L1
#             L2
#             L3
#             L4
#             ...
#             ...
#             ...
#             ...
#             L100
#         $A = 4 and $B = 12
#         Output:
#             L4
#             L5
#             L6
#             L7
#             L8
#             L9
#             L10
#             L11
#             L12
#
#
#       notes:
#
#         never actually having had call to use the flip-flop
#         operator to parse line numbers, I had to look up the
#         syntax ($. "Current line number for the last filehandle
#         accessed."). On the PerlMonk site I found a
#         clarification by our own Choroba. So with that guidance
#         I carried on. Credit where credit due; thanks for the
#         tip.
# 
#         Unless by some coincidence there are *two* Perlesque
#         Chorobas out there, an E. Choroba and a just plain
#         Choroba. I mean, it is quite likely there are more than
#         one, after all. That might be cause for worry as they
#         might meet up and attempt to take over the world. We'll
#         have to watch for that. 
# 
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## remove these from @ARGV first
my $from = shift @ARGV;
my $to   = shift @ARGV;

## need to use $. the line number special variable
while (<>) {
    print if $. == $from .. $. == $to;

}

