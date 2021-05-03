#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

## These are the dictionary's supplied by Ubuntu.
##
##   Name:    # words
##   -------  -------
##   small:    50,790
##   large:   166,828
##   huge:    344,861
##   insane:  654,299

say longest( '/usr/share/dict/british-english-small'  );
say longest( '/usr/share/dict/british-english-large'  );
say longest( '/usr/share/dict/british-english-huge'   );
say longest( '/usr/share/dict/british-english-insane' );

sub longest {
  open my $fh, q(<), $_[0];
  my @max = (0);
     (chomp)         ## Remove newline character
  && !/\W/           ## Remove words with non-alpha chars
  && !/^[A-Z]/       ## Remove words starting with a capital
  && ( lc $_ eq join q(), sort split //, lc $_ )
                     ## Check the word is unchanged when the
                     ## letters are sorted
  && ( $max[0] < length $_
     ? ( @max = ( length $_, $_ ) )
    ## If the word is longer than the max length (1st entry
    ## in @max - reset max to include the new max length and
    ## the word.)
     : ( ( $max[0] == length $_ ) && (push @max, $_ ) )
     )
    ## If the word is the same length as the maximal word
    ## push it onto @max - so we store all the longest words
    ## with maximum length.
    while <$fh>;
  return "$_[0] > @max";
  ## Return the name of the file used, the size of the words
  ## and a complete list of the words of that length.
}

sub longest_no_comments {
  open my $fh, q(<), $_[0];
  my @max = (0);
     (chomp) && !/\W/ && !/^[A-Z]/
  && ( lc $_ eq join q(), sort split //, lc $_ )
  && ( $max[0] < length $_ ? ( @max = ( length $_, $_ ) ) :
       ( ( $max[0] == length $_ ) && (push @max, $_ ) ) )
     while <$fh>;
  return "$_[0] > @max";
}

## Long words that you may not recognise....
##
## All 21 of the 6 letter words in the "small" dictionary
## are common words.
##
## Two (billowy & beefily) are common in the "huge" list
## The other two 7 letter words are:
##
##   chikors - An alternative spelling of chukars - A
##             species of partridge native to central
##             Asia (Alectoris chukar).
##
##   dikkops - (From afrikaans) A bird of the family
##             Burhinidae. The stone curlew, thick-knee
##             Comes from dik-kop or thick head
##
## Finally the 8 letter word in the insane diction is:
##
##   aegilops - a genus of Eurasian and North American
##              plants in the grass family, Poaceae.
##              They are known generally as goatgrasses.
##              Some species are known as invasive weeds
##              in parts of North America.


