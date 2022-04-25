#! /usr/bin/perl6

use Test;

plan 4;

is(generate("978-0-306-40615-"),7,'example 1');
is(generate("978-0-306-40615-7"),7,'example 2');
is(validate("978-0-306-40615-7"),True,'example 3');
is(validate("978-0-306-46015-7"),False,'example 4');

sub generate($in0) {
  my $in = $in0;
  $in ~~ s:g/<-[0..9]>+//;
  if ($in.chars < 12) {
    return 99;
  }
  my $s=0;
  my $m=1;
  for (0..11) -> $i {
    $s += substr($in,$i,1) * $m;
    $m = 4 - $m;
  }
  return (10-($s % 10)) % 10;
}

sub validate($in0) {
  my $in = $in0;
  $in ~~ s:g/<-[0..9]>+//;
  if ($in.chars != 13) {
    return 0;
  }
  return generate($in) == substr($in,12,1);
}
