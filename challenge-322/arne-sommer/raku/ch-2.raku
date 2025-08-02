#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1
                  && all(@ints) ~~ Int,
               :v(:$verbose));

my @sorted = @ints.sort.squish;

my %rank;
my $rank = 0;

for @sorted -> $val
{
  $rank++;

  %rank{$val} = $rank;

  say ": Int $val has rank $rank" if $verbose;
}

my @rank = @ints.map({ %rank{$_} });

say "({ @rank.join(", ") })";
