#!/usr/bin/env perl
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-14
Challenge 208 Minimum Index Sum ( Perl )
------------------------------------------
=cut

use strict;
use warnings;
use feature 'say';

my @list1 = (["Perl", "Raku", "Love"],["A","B","C"], ["A", "B", "C"]);
my @list2 = (["Raku", "Perl", "Hate"],["C","A","B"], ["D", "E", "F"]);

my $ln = scalar @list1;

for (0..$ln - 1) {
    my @isect = ();
    my $ref1 = $list1[$_];
    my $ref2 = $list2[$_];

    print "Input: \@list1 = @$ref1\n";
    print "       \@list2 = @$ref2\n";

    foreach my $item (@$ref1) {
        push @isect, $item if grep {  $item eq $_ } @$ref2;
    }

    print "Output : (";
    for my $item (@isect) {

        print "'",$item,"' ";
    }
    say ")\n";
}

=begin comment
------------------------------------------
perl .\MinIndexSum.pl
Input: @list1 = Perl Raku Love
       @list2 = Raku Perl Hate
Output : ('Perl' 'Raku' )

Input: @list1 = A B C
       @list2 = C A B
Output : ('A' 'B' 'C' )

Input: @list1 = A B C
       @list2 = D E F
Output : ()
------------------------------------------



=cut
