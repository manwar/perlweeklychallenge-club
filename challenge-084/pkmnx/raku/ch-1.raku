#!/usr/bin/env rakudo

sub MAIN( $in ) {

  my $rev = ( $in < 0 ??-1 !!1 ) * $in.abs().split('').reverse().join('');
  my $out = $rev.abs() >= ( 2 ** 31 ) ??0 !!$rev;

  say "Input: $in";
  say "Output: $out";

}
