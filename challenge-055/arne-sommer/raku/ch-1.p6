#! /usr/bin/env raku

# subset Binary of Int where * ~~ /^<[01]>*$/;
subset Binary where * ~~ /^<[01]>*$/;

unit sub MAIN (Binary $binary, :$verbose);

my $size = $binary.chars;
my %result;

say ": Binary number $binary with length $size" if $verbose;

for ^$size -> $l
{
  for $l .. $size-1 -> $r
  {
    my $new   = flip-binary($binary, $l, $r);
    my $count = count-ones($new);

    %result{$count}.push("L=$l, R=$r -> $new");
    say ": $binary + L:$l R:$r -> $new C:$count" if $verbose;
  }
}

say ": Hash: { %result.raku }" if $verbose;

my $answer = %result.keys.max;

say "The highest number of ones: $answer";

.say for @(%result{$answer});

sub flip-binary (Binary $number is copy, $l, $r)
{
  for $l .. $r -> $index
  {
    $number.substr-rw($index,1) = $number.substr($index,1) eq "1" ?? "0"!! "1";
  }
  return $number;
}

sub count-ones (Binary $number)
{
  return $number.comb.grep( * == "1" ).elems;
}