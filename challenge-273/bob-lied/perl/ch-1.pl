#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 273 Task 1 Percentage of Character
#=============================================================================
# You are given a string, $str and a character $char.
# Write a script to return the percentage, nearest whole, of given
# character in the given string.
# Example 1 Input: $str = "perl", $char = "e"
#           Output: 25
# Example 2 Input: $str = "java", $char = "a"
#           Output: 50
# Example 3 Input: $str = "python", $char = "m"
#           Output: 0
# Example 4 Input: $str = "ada", $char = "a"
#           Output: 67
# Example 5 Input: $str = "ballerina", $char = "l"
#           Output: 22
# Example 6 Input: $str = "analitik", $char = "k"
#           Output: 13
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;
my $Benchmark = 0;
my $Counter = 'saturn';

# Different ways to count the occurrence of a character in a string.
# Sample benchmark run on my system:
#                Rate splitgrep    delete   grepcmp    treval     match    saturn
# splitgrep   44683/s        --      -26%      -39%      -84%      -94%      -96%
# delete      60386/s       35%        --      -18%      -78%      -91%      -94%
# grepcmp     73314/s       64%       21%        --      -73%      -89%      -93%
# treval     274725/s      515%      355%      275%        --      -60%      -73%
# match      694444/s     1454%     1050%      847%      153%        --      -31%
# saturn    1000000/s     2138%     1556%     1264%      264%       44%        --

my %CountChar = (
    # Solution 1: delete everything that isn't char, use remaining length
    delete => sub($str, $char) { length( $str =~ s/[^$char]//gr )  },
 
    # Solution 2: Global match in list context yields an array of
    # matching characters. Assigning to scalar yields length of the list.
    match => sub($str, $char) { scalar( @{[ $str =~ m/$char/g ]} ) },

    # Solution 3: Same array/scalar idea, but use =()= to get context
    saturn => sub($str, $char) { my $occur =()= ( $str =~ m/$char/g ) },

    # Solution 4: turn string into array and count with grep
    splitgrep => sub($str, $char) { scalar( grep /$char/, split(//, $str) ) },

    # Solution 4a: use string compare instead of RE in grep
    grepcmp => sub($str, $char) { scalar( grep {$_ eq $char} split(//, $str) ) },

    # Solution 5: count with tr///, needs eval to interpolate
    treval => sub($str, $char) { eval "\$str =~ tr/$char//d" },
);

GetOptions("test" => \$DoTest, "benchmark:i" => \$Benchmark, "counter:s" => \$Counter);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say pctOfChar(@ARGV, $CountChar{$Counter});


sub pctOfChar($str, $char, $counter)
{
    my $occur = $counter->($str, $char);
    return int( 100*($occur / length($str)) + 0.5 );
}

sub runTest
{
    use Test2::V0;

    for my $countFunc ( sort keys %CountChar )
    {
        is( pctOfChar("perl",      "e", $CountChar{$countFunc}), 25, "Example 1 perl e $countFunc");
        is( pctOfChar("java",      "a", $CountChar{$countFunc}), 50, "Example 2 java a $countFunc");
        is( pctOfChar("python",    "m", $CountChar{$countFunc}),  0, "Example 3 python m $countFunc");
        is( pctOfChar("ada",       "a", $CountChar{$countFunc}), 67, "Example 4 ada a $countFunc");
        is( pctOfChar("ballerina", "l", $CountChar{$countFunc}), 22, "Example 5 ballerina l $countFunc");
        is( pctOfChar("analitik",  "k", $CountChar{$countFunc}), 13, "Example 6 analitik k $countFunc");

        is( pctOfChar("rrrr", "r", $CountChar{$countFunc}), 100, "100% $countFunc");
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = 'abcdefghijklmnopqrstuvwxy' x 10;

    cmpthese($repeat, {
            "delete"    => sub { pctOfChar($str, 'n', $CountChar{delete}) },
            "match"     => sub { pctOfChar($str, 'n', $CountChar{match}) },
            "saturn"    => sub { pctOfChar($str, 'n', $CountChar{saturn}) },
            "splitgrep" => sub { pctOfChar($str, 'n', $CountChar{splitgrep}) },
            "grepcmp"    => sub { pctOfChar($str, 'n', $CountChar{grepcmp}) },
            "treval"    => sub { pctOfChar($str, 'n', $CountChar{treval}) },
        });

}
