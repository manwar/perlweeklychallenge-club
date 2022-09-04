#!/usr/bin/raku

sub MAIN(
     $i,  #= a number to use as a filter
     *@n  #= a list of numbers to trim
) {
    @n.grep({ $_ > $i}).join(q{, }).say;
}