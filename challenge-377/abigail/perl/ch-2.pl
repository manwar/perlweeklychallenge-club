#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my @words = split " " => $line;
    my $count = 0;
    for (my $i = 0; $i < @words - 1; $i ++) {
        for (my $j = $i + 1; $j < @words; $j ++) {
            my $w1 = $words [$i];
            my $w2 = $words [$j];
            ($w1, $w2) = ($w2, $w1) if length ($w2) > length ($w1);
            $count ++ if index ($w1, $w2) == 0 &&
                        rindex ($w1, $w2) == length ($w1) - length ($w2)
        }
    }
    say $count;
}


__END__
