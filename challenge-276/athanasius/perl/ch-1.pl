#!perl

################################################################################
=comment

Perl Weekly Challenge 276
=========================

TASK #1
-------
*Complete Day*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @hours.

Write a script to return the number of pairs that forms a complete day.

    A complete day is defined as a time duration that is an exact multiple of
    24 hours.

Example 1

  Input: @hours = (12, 12, 30, 24, 24)
  Output: 2

  Pair 1: (12, 12)
  Pair 2: (24, 24)

Example 2

  Input: @hours = (72, 48, 24, 5)
  Output: 3

  Pair 1: (72, 48)
  Pair 2: (72, 24)
  Pair 3: (48, 24)

Example 3

  Input: @hours = (12, 18, 24)
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Hours are unsigned integers; negative hours are excluded.
2. The pair (0, 0) is accepted as a "complete day" because it meets the
   definition: "a time duration that is an exact multiple of 24 hours."

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input hours are entered as a non-empty list of unsigned integers at the
   tail of the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $DAY      => 24;
const my $HALF_DAY => int( $DAY / 2 );
const my $USAGE    => <<END;
Usage:
  perl $0 [--verbose] [<hours> ...]
  perl $0

    --verbose        Explain the output? [default: False]
    [<hours> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 276, Task #1: Complete Day (Perl)\n\n";
}

#-------------------------------------------------------------------------------
package DayPair
#-------------------------------------------------------------------------------
{
    use Moo;
    use Types::Common::Numeric qw( PositiveOrZeroInt );
    use namespace::clean;

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    has lhs =>
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (
        is  => 'ro',
        isa =>  PositiveOrZeroInt
    );

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    has rhs =>
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (
        is  => 'ro',
        isa =>  PositiveOrZeroInt
    );

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub BUILD                                                     # Sanity check
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self) = @_;

        ($self->{ lhs } + $self->{ rhs }) % $DAY == 0 or die 'Invalid DayPair';
    }
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($verbose, $hours) = parse_command_line();

        printf "Input:  \@hours = (%s)\n", join ', ', @$hours;

        my $pairs = find_day_pairs( $hours );
        my $count = scalar @$pairs;

        print  "Output: $count\n";

        if ($verbose && $count > 0)
        {
            print "\n";

            my $n = 1;

            printf( "Pair %d: (%d, %d)\n", $n++, $_->lhs, $_->rhs ) for @$pairs;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_day_pairs
#-------------------------------------------------------------------------------
{
    my ($hours) = @_;
    my  @pairs;
    my  @sorted_hours;

    for my $hour (@$hours)
    {
        my $mod = $hour % $DAY;

        push $sorted_hours[ $mod ]->@*, $hour;
    }

    push @pairs, pair_identical_mods( $sorted_hours[     0     ] );     # Mod  0
    push @pairs, pair_identical_mods( $sorted_hours[ $HALF_DAY ] );     # Mod 12

    for my $i (1 .. $DAY - 1)
    {
        next if $i == $HALF_DAY;

        if ($sorted_hours[ $i ])
        {
            $sorted_hours[ $i ] =
                [ sort { $a <=> $b } uniqint $sorted_hours[ $i ]->@* ];
        }
    }

    push @pairs, pair_complementary_mods( \@sorted_hours );

    @pairs = sort { $b->lhs <=> $a->lhs || $b->rhs <=> $a->rhs } @pairs;

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub pair_identical_mods
#-------------------------------------------------------------------------------
{
    my ($hours_ref) = @_;
    my  @pairs;

    if (defined $hours_ref && scalar @$hours_ref >= 2)
    {
        my @hours = sort { $b <=> $a } @$hours_ref;
        my $last_left;

        for my $i (0 .. $#hours - 1)
        {
            my $left = $hours[ $i ];

            next if defined $last_left && $last_left == $left;

            my $last_right;

            for my $j ($i + 1 .. $#hours)
            {
                my $right = $hours[ $j ];

                next if defined $last_right && $last_right == $right;

                push @pairs, DayPair->new( lhs => $left, rhs => $right );

                $last_right = $right;
            }

            $last_left = $left;
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub pair_complementary_mods
#-------------------------------------------------------------------------------
{
    my ($sorted_hours) = @_;
    my  @pairs;

    for my $i (1 .. $HALF_DAY - 1)
    {
        for my $left ($sorted_hours->[ $i ]->@*)
        {
            my $j = $DAY - $i;

            for my $right ($sorted_hours->[ $j ]->@*)
            {
                my ($lhs, $rhs) = ($left > $right) ? ($left, $right)
                                                   : ($right, $left);

                push @pairs, DayPair->new( lhs => $lhs, rhs => $rhs );
            }
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions
    (
        verbose => \$verbose
    )                          or error( 'Error in command line arguments' );

    my @hours = @ARGV;

    scalar @hours > 0          or error( 'Missing command-line input' );

    for (@hours)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        $_ >= 0                or error( qq["$_" is negative] );
    }

    return ($verbose, \@hours);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            $line =~ s/ \\ $ / /x;

            my $next = <DATA>;

            $next =~ s/ ^ \s+ //x;
            $line .= $next;
        }

        my  ($test_name, $hours_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $hours_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @hours    = split / \s+ /x, $hours_str;
        my $pairs    = find_day_pairs( \@hours );
        my $expected = get_expected( $expected_str );

        is_deeply $pairs, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub get_expected
#-------------------------------------------------------------------------------
{
    my ($expected_str) = @_;
    my  @expected;

    for my $pair_str (split / ; \s* /x, $expected_str)
    {
        my ($left, $right) = split / \s+ /x, $pair_str;

        push @expected, DayPair->new( lhs => $left, rhs => $right );
    }

    return \@expected;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|12 12 30 24 24           |24 24; 12 12
Example 2|72 48 24  5              |72 48; 72 24; 48 24
Example 3|12 18 24                 |
1-off    | 1 23 25 47 49 71 23 23  |71 49; 71 25; 71  1; 49 47; 49 23; 47 25; \
                                    47  1; 25 23; 23  1
7-off    | 7 17 17 31 65           |65 31; 65  7; 31 17; 17  7
Combined |65  1 31 23 17 25 7 47 71|71 25; 71  1; 65 31; 65  7; 47 25; 47  1; \
                                    31 17; 25 23; 23  1; 17  7
