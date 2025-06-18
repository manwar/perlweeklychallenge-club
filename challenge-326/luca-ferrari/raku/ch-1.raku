#!raku

#
# Perl Weekly Challenge 326
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
#

sub MAIN( Str $date ) {
    my $day = Date.new: $date;
    say 1 + $day - Date.new: month => 1, day => 1, year => $day.year;
}
