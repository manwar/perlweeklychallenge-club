#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems > 0 && all(@nums) == 0 | 1,
               :v(:$verbose));

my $bin = "";
my @divisible;

for @nums -> $digit
{
  $bin ~= $digit;

  my $decimal = $bin.parse-base(2);
  my $is-div  = $decimal %% 5;
  say ":Binary $bin Decimal $decimal { $is-div ?? "divisible by 5" !! "" } " if $verbose;
  @divisible.push: $is-div;
}

say "({ @divisible.join(", ") })";