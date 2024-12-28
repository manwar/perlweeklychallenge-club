use strict;

my @numbers;
foreach my $int (@ARGV) {
    foreach my $number (split //, $int) {
        push @numbers, $number;
    }
}
print join('', sort { $b <=> $a} @numbers)."\n";
