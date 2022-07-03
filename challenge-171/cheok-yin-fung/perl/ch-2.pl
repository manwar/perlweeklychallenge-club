#!/usr/bin/perl
# The Weekly Challenge 171
# Task 2 First-class Function
use v5.30.0;
use warnings;

sub compose {
    my $f = $_[0];
    my $g = $_[1];
    return sub {
        return $f->($g->(@_));
    }
}


sub multiply {
    return sub {
        my $prod = $_[0]*$_[1];
        return $prod;
    }
}


sub add {
    return sub {
        my $sum = $_[0]+$_[1];
        return $sum;
    }
}


sub inc {
    return sub {
        my $sum = $_[0]+1;
        return $sum;
    }
}


sub double {
    return sub {
        my $prod = $_[0]*2;
        return $prod;
    }
}



use Test::More tests => 9;

for (3..10) {
    ok compose(double, inc)->($_) == double->(inc->($_));
}

ok compose(double, multiply)->(4, 25) == 200;
