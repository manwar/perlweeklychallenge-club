#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub brute_force {
    my ($binary, $size) = @_;
    my @strings = $binary =~ /(.{$size})/g;
    die "Can't split evenly" unless @strings * $size == length $binary;

    my $same = 0 x $size;
    my $best = $size * @strings;
    until ($size < length $same) {
        my $flips = sum(map { ($_ ^ $same) =~ tr/\x01// } @strings);
        $best = $flips if $flips < $best;
        $same = sprintf "%0${size}b", 1 + oct "b$same";
    }
    return $best
}

sub by_pos {
    my ($binary, $size) = @_;
    my @strings = $binary =~ /(.{$size})/g;
    die "Can't split evenly" unless @strings * $size == length $binary;

    my $sum = 0;
    for my $pos (0 .. $size - 1) {
        my $ones += grep { substr $_, $pos, 1 } @strings;
        $sum += $ones > @strings / 2 ? @strings - $ones : $ones;
    }
    return $sum
}

use Test::More;

for my $example (['101100101', 3, 1],
                 ['10110111', 4, 2],
                 ['0000000101101011', 2, 6],
                 ['000000101010111000110011001111110101', 6, 16],
                 ['000111111', 3, 3],
                 ['00000001001001001000', 4, 4],
                 ['0000100011101010', 4, 4]
){
    is by_pos(@$example[0, 1]), $example->[-1];
    is by_pos(@$example), brute_force(@$example);
}

my $long = '101010101000100010010010111100010010101010101101001010100010101';
is brute_force($long, 3), by_pos($long, 3);

done_testing();

use Benchmark qw{ cmpthese };

cmpthese(-3, {
    brute_force => sub { brute_force($long, 3) },
    by_pos      => sub { by_pos($long, 3) },
});

__END__
               Rate brute_force      by_pos
brute_force 24884/s          --        -69%
by_pos      80637/s        224%          --
