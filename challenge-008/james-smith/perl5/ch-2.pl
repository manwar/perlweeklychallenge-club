use strict;
use feature 'say';
use List::Util qw(max);

sub center {
  my $ml = max map { length $_ } @_;
  say ' ' x (($ml-length$_)/2), $_ foreach @_;
}

print center( "This", "is", "a test of the", "center function");
