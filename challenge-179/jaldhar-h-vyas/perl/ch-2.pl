#!/usr/bin/perl
use 5.038;
use warnings;
use utf8;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

binmode(STDOUT, ':utf8');
my @n = @ARGV;
my @bars = qw/▁ ▂ ▃ ▄ ▅ ▆ ▇ █/;
my $min = min(@n);
my $max = max(@n);

for my $n (@n) {
    print $n
        ? @bars[ min(@bars * ($n - $min) / ($max - $min), @bars - 1) ]
        : ' ';

}
print "\n";
