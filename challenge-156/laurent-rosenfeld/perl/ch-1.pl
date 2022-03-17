use strict;
use warnings;
use feature "say";

my $count = 0;
my %primes = map { $_ => 1 } (2, 3, 5, 7, 11, 13, 17, 19);

for my $n (2..100) {
    my $bin = sprintf "%b", $n;
    my $num_1 = 0;
    $num_1 += $_ for split "", $bin;
    if (exists $primes{$num_1}) {
        $count++;
        print "$n, " and next if $count < 10;
        say $n and last;
    }
}
