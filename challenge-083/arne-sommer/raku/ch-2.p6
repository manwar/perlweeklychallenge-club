#! /usr/bin/env raku

subset Positive of Numeric where * > 0;

unit sub MAIN (*@A where @A.elems > 0 && all(@A) ~~ Positive, :v($verbose));

my %sum;

do_it( (), @A);

my $lowest-sum = %sum.keys.grep( * >= 0).min;

say ": Lowest non-negative sum: $lowest-sum" if $verbose;

my @flip;

for @(%sum{$lowest-sum}) -> @candidate
{
  state $index = 0;
  @flip[$index] = @candidate.grep( * < 0).elems;
  say ": Match $index: [{ @candidate.join(", ") }] with @flip[$index] flip(s)" if $verbose;
  $index++;
}

say ": Flips: [{ @flip.join(", ") }]" if $verbose;

say @flip.min;

sub do_it (@left, @right is copy)
{
  my $current = @right.shift;

  unless defined $current
  {
    say ": Candidate [{ @left.join(", ") }] with sum {@left.sum }" if $verbose;
    
    %sum{@left.sum}.push: @left;
    return;
  }

  do_it((@left,  $current).flat, @right);
  do_it((@left, -$current).flat, @right);
}
