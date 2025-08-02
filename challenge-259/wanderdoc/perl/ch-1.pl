#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a start date and offset counter. Optionally you also get bank holiday date list.
Given a number (of days) and a start date, return the number (of days) adjusted to take into account non-banking days. In other words: convert a banking day offset to a calendar day offset.
Non-banking days are:
a) Weekends
b) Bank holidays
Example 1 Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
Output: '2018-07-04' Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2 Input: $start_date = '2018-06-28', $offset = 3
Output: '2018-07-03'
=cut


use Time::Piece;
use Time::Seconds;
use Test2::V0;

is(days_offset('2018-06-28', 3, ['2018-07-03']), '2018-07-04', 'Example 1');
is(days_offset('2018-06-28', 3                ), '2018-07-03', 'Example 2');
done_testing();


sub days_offset
{
     my $start_day = $_[0];
     my $offset = $_[1];
     my $bank_holidays_aref = $_[2];
     my %bank_holidays;
     my $date_format = "%Y-%m-%d";
     
     @bank_holidays{ map Time::Piece->strptime($_, $date_format), @{$bank_holidays_aref}} = undef;
      
     my $date_ts = Time::Piece->strptime($start_day, $date_format);
     my $counter = 0;
     while ( $counter < $offset )
     {
          $date_ts += ONE_DAY;
          $counter++;

          if ( exists $bank_holidays{$date_ts}  
               or $date_ts->day_of_week == 0 # Sunday
               or $date_ts->day_of_week == 6 # Saturday
          )
          {
               $counter--;
          }
     }
     return $date_ts->ymd('-');
}
