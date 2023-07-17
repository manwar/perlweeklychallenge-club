#!/usr/bin/perl
use 5.030;
use warnings;

sub isValid {
    my ($num) = @_;
    return length $num < 2 || substr($num, 0, 1) != '0';
}

sub checkAddition {
    my ($res, $a, $b, $c) = @_;
    if (!isValid($a) || !isValid($b)) {
        return undef;
    }
    my $sum = $a + $b;

    if ($sum eq $c) {
        push @{$res}, $sum;
        return 1;
    }

    if (length $c <= length $sum || $sum != substr($c, 0, length $sum)) {
        return undef;
    } else {
        push @{$res}, $sum;

        return checkAddition($res, $b, $sum, substr($c, length $sum));
    }
}

sub additiveSequence {
    my ($n) = @_;
    my @res;
    my $l = length $n;

    for my $i (1 .. int($l / 2) + 1) {
        for my $j (1 .. int(($l - $i) / 2) + 1) {
            if (checkAddition(\@res, substr($n, 0, $i), substr($n, $i, $j), substr($n, $i + $j))) {
                unshift @res, substr($n, $i, $j);
                unshift @res, substr($n, 0, $i);
                return @res;
            }
        }
    }

    return ();
}

my $num = shift @ARGV;
my @seq = additiveSequence($num);
say scalar @seq > 0 ? 'true' : 'false';
