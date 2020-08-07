#!/usr/bin/perl6

sub MAIN(
    Int $X,     #= number of digits in output numbers
    Int $Y,     #= output numbers must be less than this amount
    *@L         #= list of input numbers
) {
    my @output =
        @L.combinations($X).map( { | ( $_.join() + 0, $_.join().flip + 0); });

    @output.push(| @L.map({ ($_ x $X) + 0; }) );

    @output.sort.grep({ $_.chars == $X && $_ < $Y; }).join(q{, }).say;
}