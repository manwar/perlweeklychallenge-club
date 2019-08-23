#! /usr/bin/perl6

my $limit=6;

for (2..Inf) -> $p {
  if $p.is-prime {
    my $q=$p+6;
    if $q.is-prime {
      say "$p, $q";
      $limit--;
      unless ($limit) {
        last;
      }
    }
  }
}
