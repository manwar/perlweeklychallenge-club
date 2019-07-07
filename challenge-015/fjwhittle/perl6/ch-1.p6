#!/usr/bin/env perl6

my $P := (^Inf).grep(*.is-prime);

my $P-strong := (1..Inf).grep({ $P[$^n] > ([+] $P[$^n X+ -1,1]) / 2 }).map: { $P[$^n] };
my $P-weak   := (1..Inf).grep({ $P[$^n] < ([+] $P[$^n X+ -1,1]) / 2 }).map: { $P[$^n] };

put 'First 10 strong primes: ' ~ $P-strong[^10].».fmt('%2d').join(', ');

put '  First 10 weak primes: ' ~   $P-weak[^10].».fmt('%2d').join(', ');
