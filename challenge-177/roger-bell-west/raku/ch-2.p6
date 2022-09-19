#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(ppc(20),
          [101, 16061, 31013, 35053, 38083, 73037, 74047, 91019,
           94049, 1120211, 1150511, 1160611, 1180811, 1190911,
           1250521, 1280821, 1360631, 1390931, 1490941, 1520251],
          'example 1');

sub isprime($candidate) {
    if (!is-prime($candidate)) {
        return False;
    } elsif ($candidate==2) {
        return True;
    } elsif ($candidate==3) {
        return True;
    } elsif ($candidate % 2 == 0) {
        return False;
    } elsif ($candidate % 3 == 0) {
        return False;
    }
    my $anchor=0;
    my $limit=floor(sqrt($candidate));
    while (True) {
        $anchor+=6;
        for ($anchor-1,$anchor+1) -> $t {
            if ($t > $limit) {
                return True;
            }
            if ($candidate % $t == 0) {
                return False;
            }
        }
    }
}

sub ppc($ct) {
  my @o;
  my $fh = 0;
  while (@o.elems < $ct) {
    $fh++;
    if ($fh ~~ /0/) {
      next;
    }
    my $c = 0 + ($fh ~ '0' ~ flip($fh));
    if (isprime($c)) {
      @o.push($c);
      if (@o.elems >= $ct) {
        last;
      }
    }
  }
  return @o;
}
