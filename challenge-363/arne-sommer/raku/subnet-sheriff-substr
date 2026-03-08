#! /usr/bin/env raku

subset IPv4 where /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/ && all($0,$1,$2,$3) < 256;
subset CIDR where /^(\d+)\.(\d+)\.(\d+)\.(\d+)\/(\d+)$/ && all($0,$1,$2,$3) < 256 && $4 <= 32;

multi sub MAIN (IPv4 $ipv4, CIDR $cidr, :v(:$verbose))
{
  my ($ip, $size) = $cidr.split(/\//);

  say ipv4_2_network($ipv4, $size, $verbose) == 
      ipv4_2_network($ip, $size, $verbose);
}

multi sub MAIN ($ipv4, $cidr, :v(:$verbose))
{
  say ": Illegal input" if $verbose;

  say False;
}

sub ipv4_2_network (IPv4 $ipv4, $size, $verbose)
{
  say ": IPv4: $ipv4 \tDecimal: { $ipv4.split('.')>>.fmt('%08b').join.parse-base(2) } - Binary: { $ipv4.split('.')>>.fmt('%08b').join } - Network: { $ipv4.split('.')>>.fmt('%08b').join.substr(0, $size) }/$size" if $verbose; 
  
  return $ipv4.split('.')>>.fmt('%08b').join.substr(0, $size);
}
