#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Permutation Ranking 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
# Write two functions, permutation2rank() which will take the list and
# determine its rank (starting at 0) in the set of possible permutations
# arranged in lexicographic order, and rank2permutation() which will take
# the list and a rank number and produce just that permutation.
# Please checkout this post for more informations and algorithm.
# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank
#
# Example: Given the list [0, 1, 2] the ordered permutations are:
#   0: [0, 1, 2]
#   1: [0, 2, 1]
#   2: [1, 0, 2]
#   3: [1, 2, 0]
#   4: [2, 0, 1]
#   5: [2, 1, 0]
# and therefore:
#   permutation2rank([1, 0, 2]) = 2
#   rank2permutation([0, 1, 2], 1) = [0, 2, 1]
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
exit(!runTest()) if $DoTest;

say permutation2rank(\@ARGV);

# How many CPU cycles have been wasted re-computing factorials?
my @Factorial = ( 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800 );

sub permutation2rank($p)
{
    use integer;
    use List::MoreUtils qw/first_index/;

    my $n = scalar(@$p);
    my $fact = 1;
    $fact *= $_ for 2 .. ($n-1);

    my @digit = 0 .. $p->$#*;
    my $r = 0;
    for my $i ( 0 .. $n-2 )
    {
        my $q = first_index { $_ == $p->[$i] } @digit;
        splice(@digit, $q, 1);

        $r += $fact * $q;
        $fact /= ($n - $i - 1);
    }
    return $r;
}

sub rank2permutation($list, $rank)
{
    use integer;
    my @perm;

    my $n = $list->$#*;

    my $fact = 1; $fact *= $_ for 2 .. $n;
    my @digit = ( 0 .. $n );

    for ( 0 .. $n )
    {
        my $q = $rank / $fact;
        $rank %= $fact;
        push @perm, $digit[$q];
        splice(@digit, $q, 1);

        $fact /= ( $n - $_ ) if ( $_ != $n );
    }
    return \@perm;
}

sub runTest
{
    use Test2::V0;

    is( permutation2rank( [ 0, 1, 2 ] ),    0,         "Example p2r 0");
    is( permutation2rank( [ 0, 2, 1 ] ),    1,         "Example p2r 1");
    is( permutation2rank( [ 1, 0, 2 ] ),    2,         "Example p2r 2");
    is( permutation2rank( [ 1, 2, 0 ] ),    3,         "Example p2r 3");
    is( permutation2rank( [ 2, 0, 1 ] ),    4,         "Example p2r 4");
    is( permutation2rank( [ 2, 1, 0 ] ),    5,         "Example p2r 5");
    is( permutation2rank( [ 2, 1, 0 ] ),    5,         "Example p2r 5");
    is( permutation2rank( [ 2, 1, 3, 0 ] ),  15,         "Example p2r 4/15");

    is( rank2permutation( [ 0, 1, 2 ], 0 ), [0, 1, 2], "Example r2p");
    is( rank2permutation( [ 0, 1, 2 ], 1 ), [0, 2, 1], "Example r2p");
    is( rank2permutation( [ 0, 1, 2 ], 2 ), [1, 0, 2], "Example r2p");
    is( rank2permutation( [ 0, 1, 2 ], 3 ), [1, 2, 0], "Example r2p");
    is( rank2permutation( [ 0, 1, 2 ], 4 ), [2, 0, 1], "Example r2p");
    is( rank2permutation( [ 0, 1, 2 ], 5 ), [2, 1, 0], "Example r2p");
    is( rank2permutation( [ 0, 1, 2, 3 ], 15 ), [2, 1, 3, 0], "Example r2p 4/15");


    done_testing;
}
