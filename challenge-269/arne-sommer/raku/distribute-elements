#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && @ints.unique.elems == @ints.elems && all(@ints) ~~ Int, :v(:$verbose));

my @arr1 = @ints.shift.Int;
my @arr2 = @ints.shift.Int;

if $verbose
{
  say ": 1st operation. Add { @arr1[*-1] } to @arr1 = ({ @arr1.join(", ") })";
  say ": 2nd operation. Add { @arr2[*-1] } to @arr2 = ({ @arr2.join(", ") })";
}

my $counter = 3;

while @ints.elems
{
  my $int   = @ints.shift.Int;
  my $last1 =  @arr1.tail;
  my $last2 =  @arr2[*-1];

  if $last1 > $last2
  {
    @arr1.push: $int;
    say ": {$counter++}rd operation. Last of @ints1 > last of @ints2: Add $int to @arr1 = ({ @arr1.join(", ") })" if $verbose;
  }
  else
  {
    @arr2.push: $int;
    say ": {$counter++}rd operation. Last of @ints2 <= last of @ints2: Add $int to @arr2 = ({ @arr2.join(", ") })" if $verbose;
  }
}

if $verbose
{
  say ": @arr1 = ({ @arr1.join(", ") })"; 
  say ": @arr2 = ({ @arr2.join(", ") })"; 
}

my @result = (@arr1, @arr2).flat;

say "({ @result.join(", ") })";
