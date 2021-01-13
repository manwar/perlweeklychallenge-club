#!/usr/bin/env perl

# tested with: raku ch-1.raku 7 4 2 6 3 / 1 3 4

use strict; use warnings;
use v5.26;
use List::MoreUtils qw(firstidx);

sub leftRotate ($$) {
    my ($A, $B) = @_;
    ($A->$#* > 0 and $B->$#* > 0) or return ($A);
    map {  if ( $_ > $A->$#* ) { warn "$_: out of range: do not change";  $A }
           else { [ $A->@[ $_ ..$A->$#*, 0..$_-1 ] ] }
    } $B->@*;
}

my $sep_pos = firstidx { !/[+-]*[1-9][0-9]*/ } @ARGV;
my @answer = leftRotate( [ @ARGV[ 0.. ($sep_pos-1) ] ],
                         [ @ARGV[ $sep_pos+1 .. $#ARGV ] ] );

say "(@$_)" for @answer;
