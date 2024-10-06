#!/usr/bin/env perl

# Challenge 171
#
# Task 2: First-class Function
# Submitted by: Mohammad S Anwar
#
# Create sub compose($f, $g) which takes in two parameters $f and $g as
# subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) =
# $f->($g->($x))
#
# e.g.
#
# $f = (one or more parameters function)
# $g = (one or more parameters function)
#
# $h = compose($f, $g)
# $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...

use Modern::Perl;

sub compose {
    my($f, $g) = @_;
    return sub { return $f->($g->(@_)); };
}

sub times3 { return 3*$_[0]; }
sub times5 { return 5*$_[0]; }
my $h = compose(\&times3, \&times5);
say $h->(shift);
