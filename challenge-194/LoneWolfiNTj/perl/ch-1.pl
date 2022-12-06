#! /usr/bin/env perl
# PWCC Challenge 194 Task 1 Perl solution by Robbie Hatley

=pod

Task 1: Digital Clock
Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.
Write a script to find the highest digit between 0-9 that makes it
valid time.

Example 1:  Input: '?5:00'  Output: 1
Example 2:  Input: '?3:00'  Output: 2
Example 3:  Input: '1?:00'  Output: 9
Example 4:  Input: '2?:00'  Output: 3
Example 5:  Input: '12:?5'  Output: 5
Example 6:  Input: '12:5?'  Output: 9

=cut

# NOTE: Input is by either default array or CL args. If inputting
#       by CL args, input must be a space-separated sequence of
#       one-or-more strings of the form '2?:17' which are capable
#       of becoming valid times if the '?' is replaced with an
#       appropriate digit.

# NOTE: Output is to stdout and will be each input string
#       followed by the highest-valued replacement for '?'
#       which makes the string a valid time.

use v5.32;

sub valid
{
   return 1 if $_[0] =~ m/^\?[0-9]:[0-5][0-9]$/;
   return 1 if $_[0] =~ m/^[0-2]\?:[0-5][0-9]$/;
   return 1 if $_[0] =~ m/^(?:(?:[0-1][0-9])|(?:2[0-3])):\?[0-9]$/;
   return 1 if $_[0] =~ m/^(?:(?:[0-1][0-9])|(?:2[0-3])):[0-5]\?$/;
   return 0;
}

my %sub =
(
   0 => sub {if (substr($_[0], 1, 1) <= 3) {return 2} else {return 1}},
   1 => sub {if (substr($_[0], 0, 1) <= 1) {return 9} else {return 3}},
   3 => sub {return 5},
   4 => sub {return 9}
);

# Default input:
my @times = ('?5:00','?3:00','1?:00','2?:00','12:?5','12:5?');

# Non-Default input:
if ( scalar(@ARGV) > 0 ) {@times = @ARGV}

for my $time (@times)
{
   if (!valid($time)) {say $time, ": ", "invalid";next}
   my $idx = index $time, '?';
   say $time, ": ", $sub{$idx}->($time);
}