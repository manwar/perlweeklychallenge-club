!/usr/bin/env perl6
# Print the last Fridays of the month for a given year.

sub MAIN ( Int $year )
{
    .say for grep { .day-of-week == 5 && (.days-in-month - .day < 7 ) },
                  (Date.new($year, 1, 1) ... Date.new($year, 12, 31) );
}
