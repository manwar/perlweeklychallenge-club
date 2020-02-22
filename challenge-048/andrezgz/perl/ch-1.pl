#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
# Task #1
#
# Survivor
# There are 50 people standing in a circle in position 1 to 50.
# The person standing at position 1 has a sword.
# He kills the next person i.e. standing at position 2 and
# pass on the sword to the immediate next i.e. person standing at position 3.
# Now the person at position 3 does the same and it goes on until only one survives.
# Write a script to find out the survivor.

use strict;
use warnings;

my @people = (1..50);
my $killed = 0;

while (@people > 1) {
    # determine who will be killed within the circle
    $killed -= @people if ++$killed > $#people;
    # declare who kills who
    printf '%2d kills %-2d'.$/, $people[$killed-1], $people[$killed];
    # remove killed one from people
    splice @people, $killed, 1;
}

# The Highlander, there can be only one
printf $/.'%d is the survivor',@people;

__END__
./ch-1.pl
 1 kills 2
 3 kills 4
 5 kills 6
 7 kills 8
 9 kills 10
11 kills 12
13 kills 14
15 kills 16
17 kills 18
19 kills 20
21 kills 22
23 kills 24
25 kills 26
27 kills 28
29 kills 30
31 kills 32
33 kills 34
35 kills 36
37 kills 38
39 kills 40
41 kills 42
43 kills 44
45 kills 46
47 kills 48
49 kills 50
 1 kills 3
 5 kills 7
 9 kills 11
13 kills 15
17 kills 19
21 kills 23
25 kills 27
29 kills 31
33 kills 35
37 kills 39
41 kills 43
45 kills 47
49 kills 1
 5 kills 9
13 kills 17
21 kills 25
29 kills 33
37 kills 41
45 kills 49
 5 kills 13
21 kills 29
37 kills 45
 5 kills 21
37 kills 5

37 is the survivor
