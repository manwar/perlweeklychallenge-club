use strict;

## Read in letters from command line... and store in %c...
## We split each argument so words can be passed in rather
## than individual letters if required...

my %counts;
for @*ARGS -> $w {
  %counts{lc $_}++ for split '',$w, :skip-empty;
}

for $*IN.lines() -> $word {
  my %copy = %counts.clone;
  say $word if checkword(lc($word),%copy);
}

## Check the word to see if it can be made up from letters
## use passing a hash by value to clone the counts so we
## don't destroy it through each loop {the method is
## destructive!}

sub checkword($word,%copy_counts) {
  for (split '',$word, :skip-empty) -> $letter {
    return if --%copy_counts{$letter} < 0;
  }
  return 1;
}
