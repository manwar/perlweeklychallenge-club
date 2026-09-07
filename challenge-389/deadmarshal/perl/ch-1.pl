#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub reorder_notes{
  my ($composer,$notes,$perm) = @{$_[0]};
  my @reordered;
  $reordered[$perm->[$_]-1] = $notes->[$_] foreach 0..$#$perm;
  uc($composer) . ' => ' . join ' ',@reordered
}

is reorder_notes(['Bach',['C','D','E','F#','G','A','B'],
		  [7,1,6,2,5,3,4]]),
  'BACH => D F# A B G E C','Example 1';
is reorder_notes(['Beethoven',
		  ['C','D','F#','G','Ab'],
		  [1, 3, 5, 2, 4]]),
  'BEETHOVEN => C G D Ab F#','Example 2';
is reorder_notes(['Brahms',
		  ['C','Db','Eb','F','G','Ab','Bb','C','D'],
		  [9,3,7,1,8,5,2,6,4]]),
  'BRAHMS => F Bb Db D Ab C Eb G C','Example 3';
is reorder_notes(['Bruckner',
		  ['G','F#','Bb','C','D','Eb','F'],
		  [4,7,2,6,1,5,3]]),
  'BRUCKNER => D Bb F G Eb C F#','Example 4';
is reorder_notes(['Berg',
		  ['C#'],
		  [1]]),'BERG => C#','Example 5';

done_testing();

