use strict;
use warnings;
use feature qw(say);

## Read in letters from command line... and store in signature

my $kw = signature( "@ARGV");

print grep { $kw eq signature($_) } <STDIN>;

## Signature algorithm - remove non alpha characters, lc,
## split and sort....

sub signature {
  return join q(), sort split //, (lc $_[0]) =~ tr/[a-z]//rcd;
}

