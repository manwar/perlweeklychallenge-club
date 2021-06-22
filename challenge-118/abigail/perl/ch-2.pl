#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl
#
# First thing which spring to mind is: there is a closed knight's tour
# on a chess board. In fact, there are 19,591,828,170,979,904 of them
# (counting rotations and reflections, but not direction). See A165134
# in the OEIS. (And there are also billions of open tours visiting all
# squares...)
#
# And any knight's tour will visit all squares, including the ones with
# treasure. So, we could just pick a tour visiting all squares and 
# calling it a day. This would turn the challenge into a glorified
# Hello World! program.
#
# So, perhaps we should focus on the bonus part. 
#
# But wait, there's no variable input. There's just a fixed board
# to work with. And one can quickly see there's an 11 step path
# visiting all the treasure, and no 10 step path.
#
# So, this challenge is yet another boring Hello, World! program.
# After all, it's much easier to write down the 11 knights moves than
# to write a program.
#
# To up the ante, we'll write a second program (ch-2a.pl) which actually
# reads input and does calculations. But the main solution will just print
# out the 11-move path.
#
# I really do hope the PWC steps away from fixed output challenges.
#

say "a8 c7 e6 c5 b3 c1 a2 c3 b1 d2 c4 b2";

__END__
