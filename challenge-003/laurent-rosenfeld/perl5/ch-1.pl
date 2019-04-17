use strict;
use warnings;
use constant limit => 100;
my @raw_hamming;
for my $pow2 (0..6) {
    for my $pow3 (0..4) {
        for my $pow5 (0..2) {
            push @raw_hamming, 2 ** $pow2 * 3 ** $pow3 * 5 ** $pow5;
        }
    }
}
my @hamming_sequence = sort { $a <=> $b } grep $_ <= limit, @raw_hamming;
print "@hamming_sequence \n";
