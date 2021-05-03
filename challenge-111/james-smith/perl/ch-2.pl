#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

## These are the dictionary's supplied by Ubuntu.

say longest('/usr/share/dict/british-english-small');
say longest('/usr/share/dict/british-english-large');
say longest('/usr/share/dict/british-english-huge');
say longest('/usr/share/dict/british-english-insane');

## Aegilops is a genus of Eurasian and North American
## plants in the grass family, Poaceae. They are known
## generally as goatgrasses. Some species are known
## as invasive weeds in parts of North America.

sub longest {
  open my $fh, q(<), $_[0];
  my @max = (0);
     (chomp)        ## Remove newline character
  && (!/\W/)        ## Remove words with non-alpha chars
  && (!/^[A-Z]/)    ## Remove words starting with a capital
  && (join( q(), sort { $a cmp $b } split //,lc $_) eq lc $_)
                     ## Check the word is unchanged when the
                     ## letters are sorted
  && ( ($max[0] < length $_)
     ? ( @max = ( length $_, $_ ) )
    ## If the word is longer than the max length (1st entry
    ## in @max - reset max to include the new max length and
    ## the word.
     : (  ($max[0] == length $_)
       && (push @max,$_)
       )
     )
    ## If the word is the same length as the maximal word
    ## push it onto @max - so we store all the longest words
    ## with maximum length.
    while <$fh>;
  return "$_[0] > @max";
  ## Return the name of the file used, the size of the words and
  ## a complete list of the words of that length.
}

