#! /usr/bin/perl

use strict;
use warnings;

if (last_word('  hello world',                qr/[ea]l/) ne 'hello') {
  die 1;
}
if (last_word("Don't match too much, Chet!",  qr/ch.t/i) ne  'Chet!') {
  die 2;
}
if (defined(last_word("spaces in regexp won't match", qr/in re/))){
  die 3;
}
if (last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/) ne '399933') {
  die 4;
}

sub last_word {
  my ($str,$re)=@_;
  my @list=reverse grep /\S/,split /\s+/,$str;
  my $r;
  foreach (@list) {
    if ($_ =~ $re) {
      $r=$_;
      last;
    }
  }
  return $r;
}
