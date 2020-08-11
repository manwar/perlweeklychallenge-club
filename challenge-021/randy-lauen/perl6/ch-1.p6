#!/usr/bin/env perl6

=begin SYNOPSIS

Task: Write a script to calculate the value of e, also known as Euler’s number and Napier’s constant.

Example output:
    $ perl6 ch-1.p6
    Calculated e = 2.718281828459045
    Perl6 e      = 2.718281828459045

=end SYNOPSIS

my $e = 0;
for ^20 -> $n {
    $e += 1/factorial($n);
}
say "Calculated e = $e";
say "Perl6 e      = {e}";

sub factorial( Int $n where * >= 0 ) {
    return 1 if $n == 0;
    return $n * factorial( $n - 1 );
}
