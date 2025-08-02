#! /usr/bin/env raku

unit sub MAIN (*@binary where @binary.elems > 0 && all(@binary) eq any(0,1),
               :v(:$verbose));

my $current = "";
my @result;

for @binary -> $digit
{
  $current ~= $digit;

  my $int   = $current.parse-base(2);
  my $prime = $int.is-prime;

  say ": Binary:$current Int:$int { $prime ?? "prime" !! "not prime" }" if $verbose;
  @result.push: $prime;
}

say "({ @result.join(", ")  })";
