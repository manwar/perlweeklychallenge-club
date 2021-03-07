#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge  02 Task #3 Hash-counting string
# You are given a positive integer $N.
# Write a script to produce Hash-counting string of that length.
#
# The definition of a hash-counting string is as follows:
# - the string consists only of digits 0-9 and hashes, ‘#’
# - there are no two consecutive hashes: ‘##’ does not appear in your string
# - the last character is a hash
# - the number immediately preceding each hash (if it exists) is the position
# of that hash in the string, with the position being counted up from 1
#
# It can be shown that for every positive integer N there is exactly one such
# length-N string.
# Examples:
# (a) "#" is the counting string of length 1
# (b) "2#" is the counting string of length 2
# (c) "#3#" is the string of length 3
# (d) "#3#5#7#10#" is the string of length 10
# (e) "2#4#6#8#11#14#" is the string of length 14
#=============================================================================

use strict;
use warnings;
use 5.032;

use experimental qw/signatures/;

use Getopt::Long;

my $doTest = 0;
my $verbose = 0;
GetOptions("test" => \$doTest, "verbose" => \$verbose);

exit(!runTest()) if $doTest;

sub Usage { "Usage: $0 N" }

my $N = shift;
die "Need a positive integer", Usage() unless defined $N && $N >= 0;

say hashCountingString($N);


sub hashCountingString($N)
{
    my $place = $N;

    # Flip back and forth between printing positions and hashes.
    use constant HASH  => 1;
    use constant PLACE => 2;
    
    # Build backwards, last character will be #
    my $str = "#";
    my $prev = HASH;

    while ( $place > 1 )
    {
        if ( $prev == HASH ) { $str = "$place$str"; $place -= length($place); $prev = PLACE; }
        else                 { $str = "#$str"     ; $place--                ; $prev = HASH; }

        say "N=[$N] place=[$place] str=[$str]" if $verbose;
    }
    return $str;
}

sub runTest
{
    use Test::More;
 
    is( hashCountingString(  1), "#",              "H   1" );
    is( hashCountingString(  2), "2#",             "H   2" );
    is( hashCountingString(  3), "#3#",            "H   3" );
    is( hashCountingString(  8), "2#4#6#8#",       "H   8" );
    is( hashCountingString(  9), "#3#5#7#9#",      "H   9" );
    is( hashCountingString( 10), "#3#5#7#10#",     "H  10" );
    is( hashCountingString( 14), "2#4#6#8#11#14#", "H  14" );
    is( hashCountingString(102), "2#4#6#8#11#14#17#20#23#26#29#32#35#38#41#44#47#50#53#56#59#62#65#68#71#74#77#80#83#86#89#92#95#98#102#", "H 102" );

    done_testing;
}
