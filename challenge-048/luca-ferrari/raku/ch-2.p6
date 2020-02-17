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


    my $current-date = Date.new( :year( $year-start ),
                                 :day(1),
                                 :month(1),
                                 formatter => { sprintf( "%02d%02d%04d", .month, .day, .year ) } );
    my $end-date     = Date.new( :year( $year-end ), :day(31), :month(12) );

    for 1 .. $end-date - $current-date {
        $current-date += 1;  # add one day at a time
        # print the date if its string representation is the same as
        # the flipped string representation
        "Palindrome: $current-date".say if $current-date.Str ~~ $current-date.Str.flip;
    }

}
