#!env perl6
# Perl Weekly Challenge 48
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/>
#
# Task 2
# Palindrome Dates
#
# Write a script to print all Palindrome Dates between 2000 and 2999.
# The format of date is mmddyyyy.
# For example, the first one was on October 2, 2001 as it is represented as 10022001.



sub MAIN( Int :$year-start? = 2000,
          Int :$year-end?   = 2999 ) {


    # since the date has to be palindrome, it means that there will be only one
    # value of days and months per year, so flipping the year around will automatically
    # produce the months and days. That also means that we can skip every year terminating
    # with two digits greates than 12, and days gtreater than 31
    for $year-start .. $year-end {
        $_ ~~ / ^ $<day>=\d ** 2 $<month>=\d ** 2 $ /;
        my $month = $/<month>.flip;
        my $day   = $/<day>.flip;
        next if  $month > 12 || $month == 0;
        next if $day > 31 || $day == 0;
        "Palindrome date %02d%02d%04d".sprintf( $month, $day, $_ ).say if try Date.new( :year( $_),
                                                                                    :month( $month),
                                                                                    :day( $day ) );
    }
}
