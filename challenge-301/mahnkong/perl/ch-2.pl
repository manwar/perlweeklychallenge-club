use strict;
use Data::Dumper;

my @numbers = @ARGV;
if ($#numbers < 1) {
    print "Please specify at least 2 numbers as argument!"
}

my $hamming_distance_sum = 0;

for (my $i = 0; $i <= $#numbers; $i++) {
    for (my $j = $i; $j <= $#numbers; $j++) {
        next if $i == $j;

        $hamming_distance_sum += hamming_distance($numbers[$i], $numbers[$j]);
    }
}

print $hamming_distance_sum . "\n";

sub hamming_distance ($$) {
    my $n1 = shift;
    my $n2 = shift;

    my $distance = 0;
    my @bin1 = split //, sprintf ("%b",$n1);
    my @bin2 = split //, sprintf ("%b",$n2);

    my $length = $#bin1 > $#bin2 ? $#bin1 : $#bin2;
    for (my $k = 0; $k = $length - $#bin1; $k ++) {
        unshift @bin1, 0;
    }
    for (my $k = 0; $k = $length - $#bin2; $k ++) {
        unshift @bin2, 0;
    }
    for (my $l = $length; $l >= 0; $l--) {
        if (int($bin1[$l]) != int($bin2[$l])) {
            $distance += 1;
        }
    }
    return $distance;
}
