use strict;
use warnings;

use lib './lib';
use Chowla;

my $c = Chowla->new;
my $numbers = $c->list(20);

for my $n (@$numbers) {
    print "$n, ";
}
