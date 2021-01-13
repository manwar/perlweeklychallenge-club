#! /usr/bin/perl6

if (last_word('  hello world',                rx/<[ea]>l/) ne 'hello') {
  die 1;
}
if (last_word("Don't match too much, Chet!",  rx/:i ch.t/) ne  'Chet!') {
  die 2;
}
if (defined(last_word("spaces in regexp won't match", rx/:s in re/))) {
  die 3;
}
if (last_word(join(' ', 1..1e6),             rx/^(3.*?) ** 3/) ne '399933') {
  die 4;
}

sub last_word ($str,$re) {
  my @list=reverse grep /\S/,split /\s+/,$str;
  my $r;
  for @list {
    if ($_ ~~ $re) {
      $r=$_;
      last;
    }
  }
  return $r;
}
