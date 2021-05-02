use strict;
use warnings;
use feature "say";

# Note: input array simulated with a string
my $in_string = "name,age,sex  Mohammad,45,m
         Joe,20,m Julie,35,f  Cristina,10,f";
my @input = split /\s+/, $in_string;
my @transposed;
for my $in (@input) {
    my $i = 0;
    for my $str (split /,/, $in) {
        push @{$transposed[$i]}, $str;
        $i++;
    }
}
for my $line (@transposed) {
    say join ',', @$line;
}
