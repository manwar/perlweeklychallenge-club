#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use constant MAX => 300000;

my %cache;

sub collatz_seq {
    my $input = shift;
    my $n = $input;
    my @result;
    while ($n != 1) {
        if (exists $cache{$n}) {
            push @result, @{$cache{$n}};
            last;
        } else {
            my $new_n = $n % 2 ? 3 * $n + 1 : $n / 2;
            push @result, $new_n;
            $cache{$n} = [$new_n, @{$cache{$new_n}}]
                if defined ($cache{$new_n}) and $n < MAX;
            $n = $new_n;
        }
    }
    $cache{$input} = [@result] if $n < MAX;
    return @result;
}

my @long_seqs;
for my $num (1..1000000) {
    my @seq = ($num, collatz_seq $num);
    push @long_seqs, [ $num, scalar @seq] if scalar @seq > 400;
}

@long_seqs = sort { $b->[1] <=> $a->[1]} @long_seqs;
say  "$_->[0]: $_->[1]" for @long_seqs[0..19];
