use strict;
use warnings;
use feature qw(say);

## Read in letters from command line... and store in %c...
## We split each argument so words can be passed in rather
## than individual letters if required...

my %counts; $counts{lc$_}++ for map{split//} @ARGV;

for my $word (<STDIN>) { chomp $word;
  say $word if checkword(lc$word,%counts);
}

## Check the word to see if it can be made up from letters
## use passing a hash by value to clone the counts so we
## don't destroy it through each loop {the method is
## destructive!}

sub checkword { my($w,%c)=@_;
  for(split//,$w) {return if --$c{$_}<0}
  return 1
}

## Below is the first try - not as elegant - but no function
## calls - just needs to use labels to jump out of inner for
## loop
##
## my $c;
## $c->{lc $_}++ foreach @ARGV;
## WORD: while (my $w=<STDIN>) {
##   chomp $w;
##   my %t = %{$c};
##   for (split //,lc $w) {
##     next WORD if --$t{$_} < 0;
##   }
##   say $w;
## }
