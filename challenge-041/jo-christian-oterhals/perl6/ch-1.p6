use v6;

use Prime::Factor;
for 1..50 {
  my @p = prime-factors($_);
  say $_ ~ " / " ~ @p if @p.elems.is-prime;
}
