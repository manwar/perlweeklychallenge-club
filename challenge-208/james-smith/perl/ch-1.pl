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
is( min_index_sum_sweep( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();

sub min_index_sum {
  my($b,%x,$t,$s,@best) =(1e99, map { $_[0][$_] => $_ } 0 .. $#{$_[0]});
  exists $x{$t = $_[1][$_]} && (
    $b > ($s=$x{$t}+$_) ? ($b,@best) = ( ($s,$t) )
                   : ($b == $s )
  ) && push @best, $t for 0 .. $#{$_[1]};
  return \@best;
}

sub min_index_sum_sweep {
  my($l1,$l2,@best)=@_;
  ($l1,$l2)=($l2,$l1) if $#$l1 > $#$l2;
  for my $l ( 0 .. $#$l1) {
    ( $l1->[$_] eq $l2->[$l-$_] ) && (push @best, $l1->[$_]) for 0..$l;
    return \@best if @best;
  }
  for my $l ( $#$l1+1 .. $#$l2 ) {
    ( $l1->[$_] eq $l2->[$l-$_] ) && (push @best, $l1->[$_]) for 0..$#$l1;
    return \@best if @best;
  }
  for my $l ( $#$l2+1 .. $#$l2+$#$l1 ) {
    ( $l1->[$_] eq $l2->[$l-$_] ) && (push @best, $l1->[$_]) for ($l-$#$l2)..$#$l1;
    return \@best if @best;
  }
  return [];
}
