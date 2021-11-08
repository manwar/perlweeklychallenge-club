use strict;
use warnings;
use DateTime;

sub get_long_years {
  # Get years with 53 weeks between 1900 and 2100

  my @result;

  for (1900..2100) {
    my $dt = DateTime->new(
      year => $_,
      month => 12,
      day => 31);

    push @result, $_ if $dt->week_number == 53;
  }

  return \@result;
}

use Test::More;

is_deeply(get_long_years(), [1903, 1908, 1914, 1920, 1925,
1931, 1936, 1942, 1948, 1953,
1959, 1964, 1970, 1976, 1981,
1987, 1992, 1998, 2004, 2009,
2015, 2020, 2026, 2032, 2037,
2043, 2048, 2054, 2060, 2065,
2071, 2076, 2082, 2088, 2093,
2099]);

done_testing;
