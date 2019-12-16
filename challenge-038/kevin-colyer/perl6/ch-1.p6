#!/usr/bin/perl6

use v6;

use Test;

=begin pod

Task 38.1

Date Finder
Create a script to accept a 7 digits number, where the first number can only be 1 or 2. The second and third digits can be anything 0-9. The fourth and fifth digits corresponds to the month i.e. 01,02,03…,11,12. And the last 2 digits respresents the days in the month i.e. 01,02,03….29,30,31. Your script should validate if the given number is valid as per the rule and then convert into human readable format date.

RULES
1) If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits to make it 4-digits year.

2) The 4th and 5th digits together should be a valid month.

3) The 6th and 7th digits together should be a valid day for the above month.

For example, the given number is 2230120, it should print 1923-01-20.

=end pod

is   validate(2230120), "1923-01-20", "Example given";
is   validate(1230120), "2023-01-20", "Example";
like validate(2230229), /'Day out of range'/,"not a Leap year";
like validate(2230631), /'Day out of range'/,"only 30 days in june";
like validate(2231330), /'Month out of range'/,"only 12 months";
like validate(22313301),/'Input must be only 7'/,"only 7 digits";
done-testing;

sub validate($d where *>0) {
    my $s=$d.Str;
    return "Input must be only 7 digits in length" if $d.chars!==7;
    my ($day,$month,$year,$mill) = $d.polymod(100,100,100);
    return "First digit must be either 1 or 2" if 0 > $mill > 2;
    $year+=$mill==1 ?? 2000 !! 1900 ;
    my $date;
    try     { $date = DateTime.new(year => $year, month => $month, day => $day);
        CATCH   { return .Str }
    };
    return $date.Date;
}
