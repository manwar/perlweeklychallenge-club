#! /usr/bin/perl6

for 2000..2999 -> $y {
  for 1..12 -> $m {
    for 1..31 -> $d {
      if ($d==31 && ($m==4 || $m==6 || $m==9 || $m==11)) {
        next;
      } elsif ($m==2 && $d==30) {
        next;
      } elsif ($m==2 && $d==29 && ($y % 4 != 0 || ($y % 100 == 0 && $y % 400 != 0))) {
        next;
      }
      my $u=sprintf('%02d%02d%04d',$m,$d,$y);
      if ($u eq $u.flip) {
        say $u;
      }
    }
  }
}