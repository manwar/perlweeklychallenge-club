#!/usr/bin/env perl

# TWC 127, TASK #1 : Disjoint Sets

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use List::MoreUtils qw(uniq);

# For this challenge

# use Data::Dump qw(pp);

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task ),
    'test'    => \( my $test )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

$test ? test() : run(@ARGV);

exit;    # End of main script.

sub run {

    # Bundle up fatal input errors to report them all at once.

    my @errors;

    push @errors,
      "This script requires two strings: Each string defining a set."
      unless 2 == @_;

    my @sets;
    for my $set (@_) {
        if ( $set =~ /\A \s* [\[\(\{]? ( [-+\d,\s]* ) [\}\)\]]? \s* \Z/xms ) {
            my $setarray = [ split( /[\s,]+/, $1 ) ];
            for my $e (@$setarray) {
                push @errors, "The element, $e, is not an integer."
                  unless $e =~ /\A [-+]? \d+ \Z/xms;
            }
            push @sets, $setarray if @$setarray;
        }
        else {
            push @errors, "The set string, '$set', is not in correct format.";
        }
    }

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( is_disjoint(@sets) );
}

exit;    # End of main script.

# The main algorithm.

sub is_disjoint {

    # This routine uses what I posted on perlmonks years ago:
    #     https://www.perlmonks.org/?node_id=898542
    #
    # It is overkill for two sets, but I would prefer it were there
    # to be three or more sets to check.

    my %soss;    # set of subsets

    for my $oldss (@_) {     # Input is list of arrays
        my @newss = map { @$_ } uniq map { $soss{$_} or [$_] } @$oldss;
        @soss{@newss} = ( \@newss ) x @newss;
    }

    return @_ == uniq values %soss;
}

# Report to STDOUT from user command line input.

sub output_results {

    say $_[0] ? '1 : Disjoint' : '0 : Not disjoint';

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my @input;

    @input = ( [ 1, 2, 5, 3, 4, ], [ 4, 6, 7, 8, 9 ], );
    is_deeply( is_disjoint(@input), !1,
        "\@S1 = (1, 2, 5, 3, 4) & \@S2 = (4, 6, 7, 8, 9) are not disjoint." );

    @input = ( [ 1, 3, 5, 7, 9, ], [ 0, 2, 4, 6, 8 ], );
    is_deeply( is_disjoint(@input), !0,
        "\@S1 = (1, 3, 5, 7, 9) & \@S2 = (0, 2, 4, 6, 8) are disjoint." );

    done_testing();
}

__END__

=head1 NAME

TWC 127, TASK #1 : Disjoint Sets

=head1 SYNOPSIS

  ch-1.pl [options] set1_string set2_string

  Description:    Given two sets of integers, say if they are disjoint.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    
    Two strings, each defining a set. The list of elements of the set are integers and can be either comma or whitespace delimited. There can be an optional containing set of brackets.


=head1 OPTIONS

=over 8

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=back

=head1 DESCRIPTION

B<L<The Weekly Challenge, TASK #1 E<gt> Disjoint Sets|https://theweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given two sets with unique integers.

Write a script to figure out if they are disjoint.

  The two sets are disjoint if they don't have any common members.


=head2 Example

  Input: @S1 = (1, 2, 5, 3, 4)
         @S2 = (4, 6, 7, 8, 9)
  Output: 0 as the given two sets have common member 4.

  Input: @S1 = (1, 3, 5, 7, 9)
         @S2 = (0, 2, 4, 6, 8)
  Output: 1 as the given two sets do not have common member.
  

=head1 INTERPRETATION

No check is made for the assertion that an input set consists of unique integers, since that has no bearing on whether the two sets are disjoint.

Checks for the containing brackets are not strict. No effort is made to enforce that they are balanced or matched, since they are just there as a convenience for people who may be cutting-and-pasting the input from the problem statement.
=cut
