#!/usr/bin/perl6

sub MAIN(
    :$A where {$_.defined}, #= A  string consisting of integers separated by spaces.
    :$B where {$_.defined}  #= A  string consisting of integers separated by spaces.
) {
    my @A = $A.split(/\s+/);
    my @B = $B.split(/\s+/);


    @B.map({ @A.rotate($_).say; });
}