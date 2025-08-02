# Task 1 of the Weekly Challenge 330
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/#TASK1

say clear-digits('cab12');  # c
say clear-digits('xy99');   # ''
say clear-digits('pa1erl'); # perl

sub clear-digits($str) {
    my $cln = S/<:L>\d// with $str;
    return $cln eq $str ?? $cln !! clear-digits($cln);
}
