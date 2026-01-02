#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int
                 && @ints.repeated.elems == 0 
                 && @ints.elems > 0,
               :v(:$verbose));

my @sorted = @ints.sort;
my $mad    = Inf;
my @res;

for 0 .. @ints.end -1 -> $i
{
  my $left  = @sorted[$i];
  my $right = @sorted[$i+1];
  my $diff  = @sorted[$i+1] - @sorted[$i];

  if $diff < $mad
  {
    say ": [$left,$right] -> diff $diff (new,reset)" if $verbose;
    $mad = $diff;
    @res = (($left,$right),);
  }
  elsif $diff == $mad
  {
    say ": [$left,$right] -> diff $diff (equal,add)" if $verbose;
    @res.push: ($left,$right);
  }
  elsif $verbose
  {
    say ": [$left,$right] -> diff $diff (ignore)" if $verbose;
  }
}

say @res.map({ "[$_[0], $_[1]]" }).join(", ");