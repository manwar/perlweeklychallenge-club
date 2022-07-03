#!/usr/bin/env perl
use v5.36;

# Task 2: First-class Function
# Submitted by: Mohammad S Anwar

# Create sub compose($f, $g) which takes in two parameters $f and $g as
# subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x)
# = $f->($g->($x))

sub compose($f, $g) {
    return sub { $f->($g->(@_)) };
}

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub double {
    return map { $_ * 2 } @_;
}

$, = " ";
my $c = compose(\&sum, \&double);
say $c->(1,2,3,4);

