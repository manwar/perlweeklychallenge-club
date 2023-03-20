#!/usr/bin/env raku
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-14
Challenge 208 Minimum Index Sum ( Raku )
------------------------------------------
=end comment
use v6;

my @list1 = (["Perl", "Raku", "Love"],["A","B","C"], ["A", "B", "C"]);
my @list2 = (["Raku", "Perl", "Hate"],["C","A","B"], ["D", "E", "F"]);

my $ln = @list1.elems;

for (0..$ln-1) -> $i {
    my @isect = ();
    my $ref1 = @list1[$i];
    my $ref2 = @list2[$i];

    print "Input: \@list1 = $ref1\n";
    print "       \@list2 = $ref2\n";

    print "Output: ";
    for (0..2) -> $x {
        if $ref1[$x] (elem) $ref2 {
            print "$ref1[$x] ";
        }
    }
    say "\n";
}

=begin comment
------------------------------------------
raku .\MinIndexSum.rk
Input: @list1 = Perl Raku Love
       @list2 = Raku Perl Hate
Output: Perl Raku

Input: @list1 = A B C
       @list2 = C A B
Output: A B C

Input: @list1 = A B C
       @list2 = D E F
Output:

------------------------------------------
=end comment
