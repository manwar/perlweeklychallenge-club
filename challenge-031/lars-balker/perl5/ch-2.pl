use v5.10;
use warnings;
use strict;

my $var = shift // die "usage: $0 <varname>";

no strict 'refs'; # we're specifically abusing this feature
$$var = $var;
say $$var;
