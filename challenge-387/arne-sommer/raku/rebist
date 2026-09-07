#! /usr/bin/env raku

subset Binary where /^ <[01]>+ $/;

unit sub MAIN (Binary $str is copy, :v(:$verbose));

my $count = 0;
my $round = 0;

while $str ~~ /01/
{
  my $index = $str.index("01");
  my @indices;

  $round++;

  while defined $index
  {
    @indices.push: $index;
    $index = $str.index("01", $index + 1);
  }

  for @indices -> $index
  {
    my $old   = $str;
    $str.substr-rw($index, 2) = "10";
    $count++;    
    say ":Round: $round [$count] Index: $index,{ $index +1} Old: $old new: $str" if $verbose;
  }
}

say $round;