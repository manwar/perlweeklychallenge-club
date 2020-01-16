#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub isBalanced {
    my ($brackets) = @_; 
    my @stack;

    map {
        if ( $brackets->[$_] eq '(' ) {
            push @stack, '(';
        } else {
            if (!scalar @stack) {
                return undef;
            }
            pop @stack;
        }
    } (0 .. scalar @{$brackets} - 1); 

    return scalar @stack == 0;
}
    
my @brackets;

for (1 .. ((int rand 3) + 1) * 2) {
    push @brackets, (int rand 2 ? '(' : ')');
}

printf "%s - %s%s\n",
    (join q{}, @brackets),
    isBalanced(\@brackets) ? q{} : 'NOT ',
    'OK';

