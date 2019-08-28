#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
Create a script that prints nth order forward difference series. You should be a 
able to pass the list of numbers and order number as command line parameters.

Usage:
    $ perl6 ch-1.p6 --order=1 5 9 2 8 1 6

Notes:
I don't really understand all the intricacies of the << hyper operator and what 
the different pointy directions mean, especially when the lists are different 
sizes. But, after fiddling with it in the perl6 REPL, I managed to find the 
behavior I was looking for.

=end SYNOPSIS

sub MAIN( Int :$order!, *@numbers where *.elems > 0 ) {
    for 1 .. $order -> $i {
        @numbers = @numbers.tail(*-1) >>->> @numbers;
        say "$i: @numbers.join(', ')";
        last if @numbers.elems == 1;
    }
}

