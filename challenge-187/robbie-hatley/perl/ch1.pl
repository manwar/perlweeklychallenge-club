#! /usr/bin/perl

=pod

Task 1: Days Together
Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city.
You are given their schedule i.e. start date and end date.

To keep the task simple, the date is in the form DD-MM and all dates
belong to the same calendar year i.e. between 01-01 and 31-12. Also
the year is non-leap year and both dates are inclusive.

Write a script to find out for the given schedule, how many days
they spent together in the city, if at all.

Example 1

Input: Foo => SD: '12-01' ED: '20-01'
       Bar => SD: '15-01' ED: '18-01'

Output: 4 days

Example 2

Input: Foo => SD: '02-03' ED: '12-03'
       Bar => SD: '13-03' ED: '14-03'

Output: 0 day

Example 3

Input: Foo => SD: '02-03' ED: '12-03'
       Bar => SD: '11-03' ED: '15-03'

Output: 2 days

Example 4

Input: Foo => SD: '30-03' ED: '05-04'
       Bar => SD: '28-03' ED: '02-04'

Output: 4 days

=cut

# NOTE: Inputs are 4 command-line arguments of the form '17-06' (meaning "June 17").
#       These will be Foo-SD, Foo-ED, Bar-SD, Bar-ED, in that order.

use v5.36;
no feature "signatures"; # I like old-style "prototypes".

# Page-global variables:

# Days per month:
my @dpm = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

# Subroutine predeclarations:
sub  slz      ($);     # strip leading zeros ( 08 -> 8 )
sub  doy      (@);     # day of year (1-365)
sub  overlap  ($$$$);  # overlap between vacations

# Main body of script:
{ # begin main
   exit if 4 != @ARGV;
   my $A1 = doy(reverse map {slz $_} split /-/, $ARGV[0]);
   my $A2 = doy(reverse map {slz $_} split /-/, $ARGV[1]);
   my $B1 = doy(reverse map {slz $_} split /-/, $ARGV[2]);
   my $B2 = doy(reverse map {slz $_} split /-/, $ARGV[3]);
   my $overlap = overlap($A1, $A2, $B1, $B2);
   say $overlap, " days";
   exit;
} # end main

# Subroutine definitions:

# Strip leading 0s:
sub slz ($)
{
   my $n = shift;
   $n =~ s/^0+(.+)$/$1/;
   return $n;
}

# Day of year:
sub doy (@)
{
   my $month = shift;      # Month (1-12 = Jan-Dec)
   my $day   = shift;      # Day of month.
   my $midx  = $month - 1; # Convert from 1-indexed to 0-indexed.
   my $idx   = 0;          # Index for riffling through months.
   my $doy   = 0;          # Day Of Year (1-365).
   for ( my $idx = 0 ; $idx < $midx ; ++$idx)
   {
      $doy += $dpm[$idx];
   }
   $doy += $day;
   return $doy;
}

# Overlap between two vacations:
sub overlap ($$$$)
{
   my $A1 = shift;  # Person A start day-of-year
   my $A2 = shift;  # Person A end   day-of-year
   my $B1 = shift;  # Person B start day-of-year
   my $B2 = shift;  # Person B end   day-of-year
   my $doy;         # day-of-year variable
   my $overlap = 0; # overlap between vacations
   die if $A1 < 1 || $A1 > 365 # A1 out-of-range
       || $A2 < 1 || $A2 > 365 # A2 out-of-range
       || $B1 < 1 || $B1 > 365 # B1 out-of-range
       || $B2 < 1 || $B2 > 365 # B2 out-of-range
       || $A1 > $A2            # A traveled back in time
       || $B1 > $B2;           # B traveled back in time
   # For each day of person A's vacation,
   # did that day overlap with person B's vacation?
   for ( $doy = $A1 ; $doy <= $A2 ; ++$doy )
   {
      if ( $doy >= $B1 && $doy <= $B2 )
      {
         ++$overlap;
      }
   }
   return $overlap;
}

__END__
