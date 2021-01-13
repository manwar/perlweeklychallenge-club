#!perl

################################################################################
=comment

Perl Weekly Challenge 061
=========================

Task #2
-------
*IPv4 Partition*

*Reviewed by: Ryan Thompson*

You are given a string containing only digits *(0..9)*. The string should have
between *4* and *12* digits.

Write a script to print every possible valid *IPv4* address that can be made by
partitioning the input string.

For the purpose of this challenge, a valid *IPv4* address consists of *four
"octets"* i.e. *A*, *B*, *C* and *D*, separated by dots (.).

Each octet must be between *0* and *255*, and must not have any leading zeroes.
(e.g., *0* is OK, but *01* is not.)

*Example*
Input: 25525511135,

Output:

 255.255.11.135
 255.255.111.35

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Algorithm::Loops qw( NextPermuteNum );
use Const::Fast;

const my $USAGE =>
    "USAGE: perl $0 <String>  --where <String> consists of 4-12 decimal digits";

const my @PARTITIONS =>                                        #    No. Possible
    (                                                          #      Partitions
        [  [ 1, 1, 1, 1 ]  ],                                  #  4 digits:    1
        [  [ 1, 1, 1, 2 ]  ],                                  #  5 digits:    4
        [  [ 1, 1, 1, 3 ], [ 1, 1, 2, 2 ]  ],                  #  6 digits:   10
        [  [ 1, 1, 2, 3 ], [ 1, 2, 2, 2 ]  ],                  #  7 digits:   16
        [  [ 1, 1, 3, 3 ], [ 1, 2, 2, 3 ], [ 2, 2, 2, 2 ]  ],  #  8 digits:   19
        [  [ 1, 2, 3, 3 ], [ 2, 2, 2, 3 ]  ],                  #  9 digits:   16
        [  [ 1, 3, 3, 3 ], [ 2, 2, 3, 3 ]  ],                  # 10 digits:   10
        [  [ 2, 3, 3, 3 ]  ],                                  # 11 digits:    4
        [  [ 3, 3, 3, 3 ]  ],                                  # 12 digits:    1
    );

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 061, Task #2: IPv4 Partition (Perl)\n\n";

    my $addresses = find_partitions( validate_input() );

    if ((my $solutions = scalar @$addresses) == 0)
    {
        print  "The string \"$ARGV[0]\" cannot be partitioned into a valid " .
               "IPv4 address\n";
    }
    else
    {
        printf "The string \"%s\" can be partitioned into %d valid IPv4 " .
               "address%s:\n",
                $ARGV[0], $solutions, ($solutions == 1 ? '' : 'es');

        print  '  ', join('.', @$_), "\n" for sort by_address @$addresses;
    }
}

#-------------------------------------------------------------------------------
sub find_partitions
#-------------------------------------------------------------------------------
{
    my ($digits) = @_;
    my  @addresses;

    for my $partition ( $PARTITIONS[ scalar @$digits - 4 ]->@* )
    {
        my @part = @$partition;         # a copy is needed here ...
        my $loop = 1;

        OUTER: while ($loop)
        {
            my @digits = @$digits;      # ... and also here
            my @octets;

            for my $i (0 .. 3)
            {
                my $octet  = '';
                   $octet .= shift @digits for 1 .. $part[ $i ];

                next OUTER if $octet > 255 ||
                             (length $octet > 1 && substr($octet, 0, 1) eq '0');

                push @octets, $octet;
            }

            push @addresses, \@octets;
        }
        continue
        {
            $loop = NextPermuteNum @part;
        }
    }

    return \@addresses;
}

#-------------------------------------------------------------------------------
sub validate_input
#-------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1  or error("Expected 1 command-line argument, found $args");

    my @digits = split //, $ARGV[0];
    my $digits = scalar @digits;

    $digits >=  4  or error("Too few digits ($digits, expected at least 4)");
    $digits <= 12  or error("Too many digits ($digits, expected at most 12)");

    / ^ [0-9] $ /x or error("Character \"$_\" is not a decimal digit")
        for @digits;

    return \@digits;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($msg) = @_;

    die "ERROR: $msg\n$USAGE\n";
}

#-------------------------------------------------------------------------------
sub by_address
#-------------------------------------------------------------------------------
{
    $a->[0] <=> $b->[0] || 
    $a->[1] <=> $b->[1] ||
    $a->[2] <=> $b->[2];
}

################################################################################
