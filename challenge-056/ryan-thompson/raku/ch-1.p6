#!/usr/bin/env perl6

# ch-1.p6 - Diff-K
#
# Ryan Thompson <rjt@cpan.org>

# Diff-K
sub diff_k( $k, @N ) {
    my %idx_of = @N.antipairs;

     @N.map( {      $k+$_, $_        } )
    ==>grep( { %idx_of{$_[0]}:exists } )
    ==> map( {   [ %idx_of{ |$_ } ]  } )
}

my @list = < 0  2  3  5  6  7  9 10 11 14 15 16 17 18 19 21 22
            25 28 29 31 32 33 34 35 37 38 40 41 44 46 47 48 49>;
say @list;

say diff_k(30, @list);
