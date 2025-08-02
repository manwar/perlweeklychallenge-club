#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0, :v(:$verbose));

my @sorted = @ints.sort;
my @unique = @sorted.unique;

say ": Sorted: @sorted[]" if $verbose;
say ": Unique: @unique[]" if $verbose;

my $current = @unique.shift;
my $count   = 1;
my $max     = 1;

for @unique -> $next
{
  $count++ if $current +1 == $next;
 
  $max = $count if $count > $max;
  
  $current = $next;
}

say $max == 1 ?? -1 !! $max;
