use strict;
use warnings;
use feature qw/say/;

my @A = (1, 2, 2, 3, 2, 4, 2, 7, 8, 9, 10);
my %histogram;
$histogram{$_}++ for @A;
my $max = 0;
for my $key (keys %histogram) {
    $max = $key unless $max;
    $max = $key if $histogram{$key} > $histogram{$max};
}
say $histogram{$max} > ( @A / 2) ? $max : -1;
