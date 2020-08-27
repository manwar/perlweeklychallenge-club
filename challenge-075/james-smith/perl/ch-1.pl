use strict;
use warnings;
use feature qw(say);

my %mem; ## Used to cache results of CSM to speed things up for large cases...

## Some test cases - example from challenge itself
say q();
_dump( csm( 6, qw(1 2 4) ) );
say q();

## All the values up to £2 - using standard UK coins
foreach (1..200) {
  _dump( csm( $_, qw(1 2 5 10 20 50 100 200) ) );
  say q();
}

# The hardwork - use recursion
sub csm {
  my $t = shift;
  return @{$mem{"$t @_"}||=[map {my $a=$_; $t==$a?[$a]:
    map {[$a,@{$_}]} csm($t-$a,grep {$a<=$_&&$_<=$t} @_)} @_] };
}

## Support function to dump values;
sub _dump {
  say "  @{$_}" foreach @_;
}

