#! /usr/bin/raku

use Test;

plan 5;

is(similarlist(['great', 'acting'], ['fine', 'drama'], [['great', 'fine'], ['acting', 'drama']]), True, 'example 1');
is(similarlist(['apple', 'pie'], ['banana', 'pie'], [['apple', 'peach'], ['peach', 'banana']]), False, 'example 2');
is(similarlist(['perl4', 'python'], ['raku', 'python'], [['perl4', 'perl5', 'raku'],]), True, 'example 3');
is(similarlist(['enjoy', 'challenge'], ['love', 'weekly', 'challenge'], [['enjoy', 'love'],]), False, 'example 4');
is(similarlist(['fast', 'car'], ['quick', 'vehicle'], [['quick', 'fast'], ['vehicle', 'car']]), True, 'example 5');

sub similarlist(@a, @b, @similar) {
  my %simmap;
  for @similar -> @simset {
    my $base = @simset[0];
    for 1 .. @simset.end -> $vn {
      %simmap{@simset[$vn]} = $base;
    }
  }
  for 0 .. @a.end -> $i {
    my $aw = %simmap{@a[$i]} || @a[$i];
    my $bw = %simmap{@b[$i]} || @b[$i];
    if ($aw ne $bw) {
      return False;
    }
  }
  True;
}
