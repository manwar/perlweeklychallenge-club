#!/usr/bin/perl

=head1

Week 171:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-171

Task #2: First-class Function

    Create sub compose($f, $g) which takes in two parameters $f and
    $g as subroutine refs and returns subroutine ref.
    i.e. compose($f, $g)->($x) = $f->($g->($x))

=cut

use v5.36;
use Test2::V0;

my $sub1 = sub { $_[0] + $_[1], $_[1] };
my $mul1 = sub { $_[0] * $_[1], $_[1] };
my $div1 = sub { $_[0] / $_[1], $_[1] };

my $sub2 = sub { $_[0] - $_[1], $_[1] };
my $mul2 = sub { $_[0] / $_[1], $_[1] };
my $div2 = sub { $_[0] * $_[1], $_[1] };

my @f = ($sub1, $mul1, $div1);
my @g = ($sub2, $mul2, $div2);

sub compose($f, $g) { return sub { $g->($f->(@_)) } }

foreach my $i (0 .. @f-1) {
    is compose($f[$i], $g[$i])->(4,2), $f[$i]->($g[$i]->(4,2));
}

done_testing;
