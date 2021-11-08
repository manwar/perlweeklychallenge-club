#!/usr/bin/env raku

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given an integer N print the number of different combinations of Fibonacci numbers that sum to it.
sub MAIN ( UInt \N,
           Bool :v($verbose) = False #= Print the list of values
         ) {
    my @res = (1,1,*+*...* > N).unique.combinations.grep(
                  -> @f { ([+] @f) == N }
              );
    say @res.elems;
    say '---' if $verbose;
    (.join(", ").say for @res) if $verbose;
}
