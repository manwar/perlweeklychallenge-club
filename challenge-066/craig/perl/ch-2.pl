use strict;
use v5.16;

my $n = shift;
die "\nMust provide positive integer.\n" if !$n || $n < 0;
my $exp = 1;
my $result;

# Work up to $n in powers of 2
do {
    $result = 2 ** $exp;
    $exp++;
} while ($result < $n);

# Find nth root up to $exp
my $i = 2;
while ($i <= $exp) {
    $result = $n ** (1/$i);
    if ($result !~ /\D/) {
        say "$result^$i";
        exit;
    } else {
        $i++;
    }
}

say "0";
