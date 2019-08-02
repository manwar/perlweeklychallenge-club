use strict;
use warnings;
use feature 'say';

## Read in letters from command line... and store sorted in string $kw...

my $kw = join q(), sort split //, (lc "@ARGV") =~ tr/[a-z]//rcd;
my $ln = length $kw;

## We are going to optimize this loop... - to avoid sorting long strings of letters...
## We only need to check those that have the same number of letters as the supplied
## word ... so we generate the unsorted keyword - and then only check the match if
## we have the same length...

## By applying this optimization we see a considerable gain in spead
say join "\n", grep {
  chomp;
  ! m{[^a-z]} &&                   ## Only include words that are all lower case (no capitals or punctuation)
  length $_ == $ln &&              ## Only words that are the same length as the input word...
  $kw eq join q(), sort split //;  ## Only those whose letters are the same...
} <STDIN>;


