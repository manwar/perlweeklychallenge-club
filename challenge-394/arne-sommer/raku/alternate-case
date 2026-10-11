#! /usr/bin/env raku

unit sub MAIN (Str $str where ($str ~~ /^ <[a..zA..Z]>+ $/)
                 && ($str.comb.grep(/<[a..z]>/).elems * 2 == $str.chars),
               :v(:$verbose));

sub is-lower(Str $c) { $c.lc eq $c }

my $best-count = Inf;
my @best-steps;
my $best-start;

for 0, 1 -> $start
{
  my @chars = $str.comb;
  my $count = 0;
  my @steps;

  for ^@chars.elems -> $i
  {
    my $want-lower = ($i % 2) == $start;

    next if is-lower(@chars[$i]) == $want-lower;

    my $j = $i + 1;

    $j++ while is-lower(@chars[$j]) != $want-lower;

    while $j > $i
    {
      my $tmp  = @chars[$j - 1];
      @chars[$j - 1] = @chars[$j];
      @chars[$j] = $tmp;
      $j--;
      $count++;
      @steps.push: @chars.join;
    }
  }

  if $count < $best-count
  {
    $best-count = $count;
    @best-steps = @steps;
    $best-start = $start;
  }
}

if $verbose
{
  my @pattern = map { ($_ % 2) == $best-start ?? "L" !! "U" }, ^$str.chars;

  say ": Target: " ~ @pattern.join(" ");

  for 1 .. @best-steps.elems -> $n
  {
    say ": Swap $n: { @best-steps[$n - 1] }";
  }
}

say $best-count;