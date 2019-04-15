use strict;

## Read in letters from command line... and store in %counts...
## We split each argument so words can be passed in rather
## than individual letters if required...
## To avoid the additional non-letter characters we have to 
## use the :skip-empty flag...

my %counts;
for @*ARGS {
  %counts{lc $_}++ for split '',$_, :skip-empty;
}

## Re-write as a one-liner by using `for grep` rather than `for {if}`...

say $_ for grep { checkword(lc $_) }, $*IN.lines();

## Rewritten this to make it non destructive - we count up rather than
## down needs another check to avoid comparing to undef...
## So this is probably a nicer way of doing it....

sub checkword($word) {
  my %tmp_counts;
  for (split '',$word, :skip-empty) {
    return unless %counts{$_} && %tmp_counts{$_}++ < %counts{$_};
  }
  return 1;
}
