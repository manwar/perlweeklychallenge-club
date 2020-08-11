#! /usr/bin/env raku

subset IP-Decimal where 4 <= .chars <= 12 && .Int;

unit sub MAIN (IP-Decimal $ip-decimal, :$verbose);

my @ipv4 = $ip-decimal.comb;

my $length  = $ip-decimal.chars - 1;
my $decimal = 2 ** $length -1;

say ": Binary mask: { 1 x $length } - $decimal" if $verbose;

CANDIDATE: for 1 .. $decimal -> $current
{
  #my $val = $current.fmt("%0" ~ $length ~ "b") ~ " ";
  my $val = $current.fmt("%0" ~ $length ~ "b");
  my $old-val = $val;

  next unless $val.comb.sum == 3;

  $val ~~ tr/01/ ./;

  my $ip = (roundrobin @ipv4, $val.comb).join.trans(' ' => '');

  say ": Iterate: $ip-decimal | $current | $old-val ($val) -> $ip: Found 4 parts" if $verbose;

  my @elems = $ip.split(".");

  next if any(@elems) > 255;

  for 0 .. 3 -> $index
  {
    next CANDIDATE if @elems[$index].Int ne @elems[$index];
  }

  say @elems.join(".");
}
