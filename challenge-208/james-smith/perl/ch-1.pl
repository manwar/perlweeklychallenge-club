#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [qw(Perl Raku Love)], [qw(Raku Perl Hate)], 'Perl Raku' ],
 [ [qw(A B C)],          [qw(D E F)         ], ''             ],
 [ [qw(A B C)],          [qw(C A B)         ], 'A' ],
 [ [qw(A B C D E F)],    [qw(A B C)         ], 'A' ],
 [ [qw(A B C)],          [qw(D E F G H C)   ], 'C' ],
 [ ['A'..'Z'],           [reverse('A'..'Z')],  "@{[ 'A'..'Z' ]}" ],
 [ ['A'..'Z'],           ['A'..'Z'],           'A' ],
 [ ['A'..'Z'],           ['a'..'z'],           '' ],
);

is( min_index_sum(       @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();

sub min_index_sum {
  my( $b, %x, $t, $s, @best ) = ( 1e99,                #0
    map { $_[0][$_] => $_ } reverse ( 0 .. $#{$_[0]} ) #1
  );
  exists $x{$t = $_[1][$_]} &&                         #3
    ( $b > ($s=$x{$t}+$_) ?  ($b,@best) = ( $s,$t )    #4
    : $b == $s            && push @best, $t )          #5
    for 0 .. $#{$_[1]};                                #2
  \@best                                               #6
}

