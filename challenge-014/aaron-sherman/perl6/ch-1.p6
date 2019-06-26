#!/usr/bin/env perl6

# Challenge #014.2
#
# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page. This challenge was
# proposed by team member Andrezgz.

# This solution is somewhat cheeting, but since I just wrote this module
# a few days ago (not knowing about the upcoming challenge) I won't feel
# bad about it. ;-)

use v6.c;

use Math::Sequences::Numberphile;

.say for @A181391;
