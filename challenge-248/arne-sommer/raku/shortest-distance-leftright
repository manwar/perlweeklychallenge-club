#! /usr/bin/env raku

unit sub MAIN ($str = "loveleetcode", $char where $char.chars == 1 = "e", :v(:$verbose));

my @input = $str.comb;
my @output;

my $distance = Inf;

for @input -> $i
{
  $distance = 0 if $i eq $char;

  @output.push: $distance;
  $distance++;    
}

say ":From left: ({ @output.join(",") })" if $verbose;

$distance = Inf;

for @input.end ... 0 -> $index
{
  $distance = 0 if @input[$index] eq $char;
  @output[$index] = $distance if $distance < @output[$index];
  $distance++;    
}

say "({ @output.join(",") })";
