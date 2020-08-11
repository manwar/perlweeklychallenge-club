#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @digits = ('1', '2', '3', '4', '5', '6', '7', '8', '9');
my @ops = (' + ', ' - ', q{});

sub X {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    return map {
        my $first = $_;
        map { 
            [ ref $first eq 'ARRAY' ? @{$first} : $first, $_ ];
        } @b;
    } @a;
}

sub Ztilde {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    my @result;
    for my $i (0 .. scalar @b - 1) {
        push @result, $a[$i], $b[$i];
    }
    return @result;
}

my @output = @ops;
for (1 .. 7) {
    @output = X(\@output, \@ops);
}
@output = X(\@output, [q{}]);

say "$_ = 100" for 
    grep { eval $_ == 100 } map { join q{}, Ztilde(\@digits, $_); } @output;
