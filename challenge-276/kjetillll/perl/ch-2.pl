use strict; use warnings; use Test::More tests => 2; use List::Util qw(max sum);

sub maximum_frequency {
    my %freq;
    $freq{ $_ }++ for @_;
    my $max_freq = max( values %freq );
    sum( grep $_ == $max_freq, values %freq )
}

is maximum_frequency( @{ $$_{input} } ), $$_{output}
  for { input => [1, 2, 2, 4, 1, 5], output=> 4 },
      { input => [1, 2, 3, 4, 5   ], output=> 5 };
