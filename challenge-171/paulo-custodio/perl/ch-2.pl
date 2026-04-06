#!/usr/bin/env perl

# Perl Weekly Challenge 171 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

use Modern::Perl;

sub compose {
    my($f, $g) = @_;
    return sub { return $f->($g->(@_)); };
}

sub times3 { return 3*$_[0]; }
sub times5 { return 5*$_[0]; }
my $h = compose(\&times3, \&times5);
say $h->(shift);
