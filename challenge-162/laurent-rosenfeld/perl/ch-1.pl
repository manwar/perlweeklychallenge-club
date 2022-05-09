use strict;
use warnings;
use feature "say";

my $isbn = "978-0-306-40615-";
my $sum = 0;
my $k = 1;
for my $i (grep {/\d/} split //, $isbn) {
    $sum += $k * $i;
    $k = $k == 1 ? 3 : 1;
}
my $check = 10 - $sum % 10;
say $check;
