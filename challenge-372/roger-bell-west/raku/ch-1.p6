#! /usr/bin/raku

use Test;

plan 5;

is(rearrangespaces('  challenge  '), 'challenge    ', 'example 1');
is(rearrangespaces('coding  is  fun'), 'coding  is  fun', 'example 2');
is(rearrangespaces('a b c  d'), 'a b c d ', 'example 3');
is(rearrangespaces('  team      pwc  '), 'team          pwc', 'example 4');
is(rearrangespaces('   the  weekly  challenge  '), 'the    weekly    challenge ', 'example 5');

sub rearrangespaces($a) {
  my @words;
  my $spaces = 0;
  my $ww = '';
  for $a.comb -> $c {
    if ($c eq ' ') {
      $spaces += 1;
      if ($ww ne '') {
        @words.push($ww);
        $ww = '';
      }
    } else {
      $ww ~= $c;
    }
  }
  if ($ww ne '') {
        @words.push($ww);
  }
  my $spdiv = 0;
  my $remainder = $spaces;
  my $divs = @words.end;
  if ($divs > 0) {
    $spdiv = floor($spaces / $divs);
    $remainder = $spaces % $divs;
  }
  my $out = join((' ' x $spdiv), @words);
  if ($remainder > 0) {
    $out ~= ' ' x $remainder;
  }
  $out;
}
