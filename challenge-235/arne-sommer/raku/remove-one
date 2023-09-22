#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int, :v(:$verbose));

# ( say 'true'; exit ) if [<] @ints;

for 0 .. @ints.end -> $index
{
  my @copy = @ints.clone;
  @copy.splice($index,1);
  say ":Index $index: remove value @ints[$index] -> @copy[]" if $verbose;
  ( say 'true'; exit ) if [<] @copy;
}

say 'false';

