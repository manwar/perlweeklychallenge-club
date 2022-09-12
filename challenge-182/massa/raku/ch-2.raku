use v6.d;

my sub parents(\f) {
  $_ = f.IO.resolve;
  reverse gather loop { .Str.take; last when '/'; $_.=parent }
}

my sub common-parent(\f1, \f2) {
  for parents(f1) Z parents(f2) -> ($a, $b) {
    last unless $a eq $b;
    $_ = $a
  }
  $_
}

@*ARGS.reduce(&common-parent).say

