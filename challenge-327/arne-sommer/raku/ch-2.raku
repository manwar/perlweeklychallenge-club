#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int
                 && @ints.elems == @ints.unique.elems,
               :v(:$verbose));

my @sort = @ints.sort;
my @diff = (1 .. @sort.end).map({ @sort[$_] - @sort[$_ -1] });
my $mad  = @diff.min;
my $set  = @ints>>.Int.Set;
my @result;

if $verbose
{
  say ": Sorted: @sort[]";
  say ": Diff: @diff[]";
}

for sort $set.keys -> $k
{
  my $is-mad = so $set{$k + $mad};

  @result.push: ($k, $k + $mad) if $is-mad;
  
  say ": $k, { $k + $mad } { $is-mad ?? "is MAD" !! "does not exist" }" if $verbose;
}

say @result.raku;