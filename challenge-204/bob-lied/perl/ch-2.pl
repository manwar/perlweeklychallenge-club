#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 204 Task 2 Reshape Matrix
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a matrix (m x n) and two integers (r) and (c).
# Write a script to reshape the given matrix in form (r x c) with the
# original value in the given matrix. If you can’t reshape print 0.
# Example 1 Input: [ 1 2 ]
#                  [ 3 4 ] $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
#                  $r = 1 $c = 4
#          Output: [ 1 2 3 4 ]
# Example 2 Input: [ 1 2 3 ]
#                  [ 4 5 6 ] $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
#                  $r = 3 $c = 2
#          Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
# Example 3 Input: [ 1 2 ] $matrix = [ [ 1, 2 ] ]
#                  $r = 3 $c = 2
#          Output: 0
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usage() { qq(echo -e "[1,2] \\n [3,4]" | $0 r c ) }

my $Row = shift;
my $Col = shift;

die 'Usage: '. usage() unless (defined $Row && $Row > 0) && (defined $Col && $Col > 0);

my $input  = readMatrix();
my $output = reshape($input, $Row, $Col);
showMatrix($output);

sub readMatrix()
{
    # Assuming one line per row, square brackets on the ends
    # and possibly separated by commas
    my @matrix;
    while (<>)
    {
        chomp;
        next if m/^\w*$/;   # Ignore blank lines
        s/[[\],]/ /g;       # Leave only numbers
        push @matrix, [ split ' ' ];    # Split on white space
    }
    return \@matrix;
}

sub reshape($matrix, $r, $c)
{
    showMatrix($matrix, "Input") if $Verbose;

    my $origR = scalar(@$matrix);
    my $origC = scalar( $matrix->[0]->@* );

    return 0 if ( ($origR * $origC) != ($r * $c) );

    my @flat = map { $_->@*  } $matrix->@*;

    my @newMatrix;
    push @newMatrix, [ splice(@flat, 0, $c) ] for 1 .. $r;
    showMatrix(\@newMatrix, "Output") if $Verbose;
    return \@newMatrix;
}

sub showMatrix($m, $title = "")
{
    my $row = scalar(@$m);

    say $title;
    for ( my $r = 0 ; $r < $row; $r++)
    {
        say +(' ' x length($title)), "[ ", join(", ", $m->[$r]->@*), " ]";
    }
}

sub runTest
{
    use Test2::V0;

    is( reshape( [ [1,2] ], 3, 2 ), 0, "Example 3");

    is( reshape([ [1,2], [3,4] ], 1, 4), [ [ 1,2,3,4 ] ] , "Example 1");

    is( reshape( [ [1,2,3], [4,5,6] ], 3, 2) , [ [1,2],[3,4],[5,6] ], "Example 2");

    done_testing;
}

