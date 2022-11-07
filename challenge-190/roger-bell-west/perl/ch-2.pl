#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

use Storable qw(freeze thaw);

is_deeply(decodedlist("11"), ["AA", "K"], 'example 1');
is_deeply(decodedlist("1115"), ["AAAE", "AAO", "AKE", "KAE", "KO"], 'example 2');
is_deeply(decodedlist("127"), ["ABG", "LG"], 'example 3');

sub decodedlist($s) {
    my @stack;
    push @stack,[$s];
    my %out;
    while (1) {
        my $ent = shift @stack;
        my $tail = pop @{$ent};
        if (length($tail) == 0) {
            $out{freeze($ent)} = 1;
        } else {
            if (substr($tail, 0, 1) ne "0") {
                push @stack, [
                  @{$ent},
                  substr($tail, 0, 1),
                  substr($tail, 1)
                    ];
            }
            if (length($tail) >= 2) {
                my $v = 0 + substr($tail, 0, 2);
                if ($v >= 1 && $v <= 26) {
                    push @stack, [
                      @{$ent},
                      substr($tail, 0, 2),
                      substr($tail, 2)
                        ];
                }
            }
        }
        if (scalar @stack == 0) {
            last;
        }
    }
    my @k;
    my $alphazero = ord("A") - 1;
    foreach my $x (keys %out) {
        push @k, join("",map {chr($alphazero + $_)} @{thaw($x)});
      }
    return [sort @k];
}
