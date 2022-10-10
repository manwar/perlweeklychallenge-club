#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Const::Fast qw(const);

## first of month - or rather"Last day of previous month" {because of
## numbering starting at 1..
## To avoid issues of leap years the number is based on leap years,
## and we adjust in code if required...

const my @FIRST_OF_MONTH => (0,0,31,60,91,121,152,182,213,244,274,305,335);

my @TESTS = (
  [ [ '2019-02-10', '2022-11-01' ], '3 years 264 days' ],
  [ [ '2020-09-15', '2022-03-29' ], '1 year 195 days' ],
  [ [ '2019-12-31', '2020-01-01' ], '1 day' ],
  [ [ '2019-12-01', '2019-12-31' ], '30 days' ],
  [ [ '2019-12-31', '2020-12-31' ], '1 year' ],
  [ [ '2019-12-31', '2021-12-31' ], '2 years' ],
  [ [ '2020-09-15', '2021-09-16' ], '1 year 1 day' ],
  [ [ '2019-09-15', '2021-09-16' ], '2 years 1 day' ],
);

is( date_diff(@{$_->[0]}), $_->[1] ) foreach @TESTS;
is( date_diff_var(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub date_diff {
  sub {   ## FINALLY: Now we just format the years/days....
    join ' ', map {
                $_[$_]
              ? $_[$_]
                . ' '
                . ( $_         ? 'day' : 'year' )
                . ( $_[$_] > 1 ? 's'   : ''     )
              : ()
              } 0 , 1
  }->(
    sub { ## THIRD: Now we take the two values and compute the duration...
          ## If the day of year of the 2nd date is greater than   day of the year for the 1st date, we
          ## know we are going forward - we have to do a quick leap year adjustment {to remove Feb 29th}
          ## if the from date is in Jan/Feb and the to date is Mar, Apr, ....
          ##
          ## Otherwise we have the tricky one - we have to subtract one from the year diff
          ## We compute the number of days to the end of the year for the from date
          ## and add it to the number of days to the to date....
          ## We have to adjust for leap years - in case the leap day "doesn't" appear between the two
          ## numbers....
          ##
          ## We return years/days....
          ##
          ## Each date is ( year, month, "not leap year" flag, day of year );
       $_[1][3] >= $_[0][3]
     ? ( $_[1][0] - $_[0][0],       $_[1][3] - $_[0][3]
                                  - ( $_[1][1] > 2 && $_[0][1] < 3 && $_[1][2] && 1 ) )
     : ( $_[1][0] - $_[0][0] - 1,   $_[1][3] - $_[0][3] + 366
                                  - ( $_[1][1] > 2 &&                 $_[1][2] && 1 )
                                  + (                 $_[0][1] < 3 && $_[0][2] && 1 ) )
    }->(
      map { ## SECOND: Add whether leap year and "day of year" {assuming Feb has 29 days}
        [ $_->[0], $_->[1],
          ( $_->[0] % 400 ) ^ ( $_->[0] % 100 ) ^ ( $_ ->[0] % 4 ),
          $FIRST_OF_MONTH[ $_->[1] ] + $_->[2]
        ]
      }     ## FIRST: Split into Y,M,D
      map { [ split/-/ ] } @_
    )
  );
}

sub date_diff_var {
  sub {   ## FINALLY: Now we just format the years/days....
    my @units = @_; # ( years, days )
    join ' ', map {
                  $units[$_]
                ? $units[$_] . ' ' . ( $_ ? 'day' : 'year' ) . ( $units[$_] > 1 ? 's' : '' )
                : ()
              } 0 , 1
  }->(
    sub { ## THIRD: Now we take the two values and compute the duration...
          ## If the day of year of the 2nd date is greater than   day of the year for the 1st date, we
          ## know we are going forward - we have to do a quick leap year adjustment {to remove Feb 29th}
          ## if the from date is in Jan/Feb and the to date is Mar, Apr, ....
          ##
          ## Otherwise we have the tricky one - we have to subtract one from the year diff
          ## We compute the number of days to the end of the year for the from date
          ## and add it to the number of days to the to date....
          ## We have to adjust for leap years - in case the leap day "doesn't" appear between the two
          ## numbers....
          ##
          ## We return years/days....
      my( $from_year, $from_month, $from_not_leap, $from_day ) = @{$_[0]};
      my( $to_year  , $to_month,   $to_not_leap,   $to_day   ) = @{$_[1]};
        $to_day >= $from_day
      ? ( $to_year-$from_year,     $to_day - $from_day
                                 - ( $to_month > 2 && $from_month < 3 && $to_not_leap   && 1 ) )
      : ( $to_year-$from_year-1,   $to_day - $from_day + 366
                                 - ( $to_month > 2                    && $to_not_leap   && 1 )
                                 + (                  $from_month < 3 && $from_not_leap && 1 ) )
    }->(
      map {
        ## SECOND: Add whether leap year and "day of year" {assuming Feb has 29 days}
        my( $year, $month, $day ) = @{$_};
        [ $year, $month, ($year%400) ^ ($year%100) ^ ($year%4), $FIRST_OF_MONTH[ $month ] + $day ]
      }
      map {
        ## FIRST: Split into Y,M,D
        [ split/-/ ]
      }
      @_
    )
  );
}

