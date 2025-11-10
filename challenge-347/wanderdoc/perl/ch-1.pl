#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a date in the form: 10th Nov 2025.

Write a script to format the given date in the form: 2025-11-10 using the set below.

@DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
@MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
@YEARS  = (1900..2100)


Example 1

Input: $str = "1st Jan 2025"
Output: "2025-01-01"


Example 2

Input: $str = "22nd Feb 2025"
Output: "2025-02-22"


Example 3

Input: $str = "15th Apr 2025"
Output: "2025-04-15"


Example 4

Input: $str = "23rd Oct 2025"
Output: "2025-10-23"


Example 5

Input: $str = "31st Dec 2025"
Output: "2025-12-31"
=cut



use Test2::V0 -no_srand => 1;


is(format_date('1st Jan 2025'), '2025-01-01', 'Example 1');
is(format_date('22nd Feb 2025'), '2025-02-22', 'Example 2');
is(format_date('15th Apr 2025'), '2025-04-15', 'Example 3');
is(format_date('23rd Oct 2025'), '2025-10-23', 'Example 4');
is(format_date('31st Dec 2025'), '2025-12-31', 'Example 5');
done_testing();

sub format_date
{
     my $str = $_[0];
     my %days = map { /1$/ ? $_ . 'st' : 
                      /2$/ ? $_ . 'nd' : 
                      /3$/ ? $_ . 'rd' : 
                      $_ . 'th', $_ } 1 .. 31;
     my @months = qw(dummy Jan Feb Mar Apr Mai Jun Jul Auf Sep Oct Nov Dec);
     my %months = map { $months[$_], $_ } 1 .. $#months; 
     my ($this_day, $this_month, $this_year) = split(/ /, $str);

     return 
          join('-',
          $this_year, sprintf("%02d", $months{$this_month}), 
                      sprintf("%02d",$days{$this_day}));
}
