#! /usr/bin/env raku

unit sub MAIN (UInt $limit = 1000);

my $fscp := (1..Inf).map( { 3 * $_ ** 2 + 3 * $_ + 1 } ).grep( *.is-prime );

my @fscp;

loop
{
  state $index = 0;
  my $current  = $fscp[$index++];
  last if $current > $limit;
  @fscp.push: $current;
}
  
@fscp.join(", ").say;
