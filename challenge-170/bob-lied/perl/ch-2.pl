#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 170 Task 2  Kronecker Product
#=============================================================================
# You are given 2 matrices.
# Write a script to implement Kronecker Product on the given 2 matrices.
# For more information, please refer wikipedia page.
# https://en.wikipedia.org/wiki/Kronecker_product
# For example,      A = [ 1 2 ]     B = [ 5 6 ]
#                       [ 3 4 ]         [ 7 8 ]
#	A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
#	        [     [ 7 8 ]       [ 7 8 ] ]
#	        [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
#	        [     [ 7 8 ]       [ 7 8 ] ]
#	
#	      = [ 1x5 1x6 2x5 2x6 ]
#	        [ 1x7 1x8 2x7 2x8 ]
#	        [ 3x5 3x6 4x5 4x6 ]
#	        [ 3x7 3x8 4x7 4x8 ]
#	
#	      = [  5  6 10 12 ]
#	        [  7  8 14 16 ]
#	        [ 15 18 20 24 ]
#	        [ 21 24 28 32 ]
#=============================================================================

use v5.42;
use Math::Matrix;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

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

my $A = Math::Matrix->new( [ [1, 2], [3, 4] ] );
my $B = Math::Matrix->new( [ [5, 6], [7, 8] ] );

my $K = $A->kron( $B );
say $K->as_string();

sub show($m)
{
    my @s = ();
    for my $row ( 0 .. $m->$#* )
    {
        push @s, "[ ". join(", ", $m->[$row]->@*) . " ]";
    }
    return join("\n", @s);
}

say show( kronprod($A->as_array, $B->as_array) );

#=============================================================================
# A and B are references to two-dimensional arrays, e.g.  [ [],[] ]
sub kronprod($A, $B)
{
    my $r_A = scalar($A->@*); my $c_A = scalar($A->[0]->@*);
    my $r_B = scalar($B->@*); my $c_B = scalar($B->[0]->@*);

    # Make a result array of the correct dimensions.
    my @K;
    for ( 1 .. ( $r_A * $r_B ) )
    {
        push @K, [ (0) x ( $c_A * $c_B ) ];
    }

    for my $a_R ( 0 .. $r_A-1 )
    {
        for my $a_C ( 0 .. $c_A-1 )
        {
            my $a = $A->[$a_R][$a_C];

            for my $b_R ( 0 .. $r_B-1 )
            {
                my $k_R = $a_R * $r_B + $b_R;

                for my $b_C ( 0 .. $c_B-1 )
                {
                    my $k_C = $a_C * $c_B + $b_C;

                    $K[$k_R][$k_C] = $a * $B->[$b_R][$b_C];
                }
            }
        }
    }
    return \@K;
}

sub runTest
{
    my $A = Math::Matrix->new( [ [1, 2], [3, 4] ] );
    my $B = Math::Matrix->new( [ [5, 6], [7, 8] ] );

    my $K = $A->kron( $B );
    my $K_array = $K->as_array();
    use Test2::V0;

    is( $K->nrow, 4, "Number of rows");
    is( $K->ncol, 4, "Number of columns");
    is( $K_array->[0], [  5,  6, 10 ,12 ], "Row 0");
    is( $K_array->[1], [  7,  8, 14, 16 ], "Row 1");
    is( $K_array->[2], [ 15, 18, 20, 24 ], "Row 2");
    is( $K_array->[3], [ 21, 24, 28, 32 ], "Row 3");

    done_testing;
}
