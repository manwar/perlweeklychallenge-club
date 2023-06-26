#!/usr/bin/env raku

#| Given a list of integer print the number of times the list and the sorted list match
sub MAIN (
    *@list where { @list.all ~~ Int() } #= List of Integers
) {
    say [+] (@list Z== @list.sort);
}
