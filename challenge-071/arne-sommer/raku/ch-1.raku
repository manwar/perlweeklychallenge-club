#! /usr/bin/env raku

subset VeryPosInt of Int where * > 1;

unit sub MAIN (VeryPosInt $N, :$v, :$verbose = $v);

my @array = (1..50).roll($N);

say ": Values: @array[]" if $verbose;

@array.push:    -1;
@array.unshift: -1;

my @peak;

for 1 .. $N  -> $index
{
  say ": Checking at position $index: (left:@array[$index-1], value: @array[$index], right:@array[$index+1])" if $verbose;
  @peak.push: @array[$index] if @array[$index] > @array[$index-1] && @array[$index] > @array[$index+1];
}

say "[ ", @peak.join(", "), " ]";
