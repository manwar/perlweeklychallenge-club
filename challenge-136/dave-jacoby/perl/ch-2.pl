#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use JSON;
use List::Util qw{ sum0 uniq };
my $json = JSON->new->pretty->canonical;

my @examples = qw{16 9 15};

for my $n (@examples) {
    my @o  = solve_task($n);
    my $o  = scalar @o;
    my $oo = join ",\n        ", map { ($_) } @o;

    say <<"END";
    Input: \$n = $n
    Output: $o
        $oo
END
}

sub solve_task ($n) {
    my @fib       = grep { $_ < $n } map { fib($_) } 1 .. $n;
    my @sequences = recursion( $n, \@fib );
    return @sequences;
}

# Let's call it what it is
sub recursion ( $n, $ref, $x = [] ) {
    my @output;
    my $depth   = 1 + scalar $x->@*;
    my $sum     = sum0 $x->@*;
    my $nex->@* = sort $ref->@*;

    return undef if $sum > $n;

    if ( $sum == $n ) {
        $x->@* = sort { $a <=> $b } map { int $_ } $x->@*;
        my $answer = join ' + ', $x->@*;
        return $answer;
    }

    for my $i ( 1 .. scalar $nex->@* ) {
        my $v = shift $nex->@*;
        my $y->@* = $x->@*;
        push $y->@*, $v;

        my @return = recursion( $n, $nex, $y );
        push @output, @return;
        push $nex->@*, $v;
    }
    return uniq sort grep { defined } @output;
}

sub fib ($n) {
    state $fib;
    $fib->{0} = 1;
    $fib->{1} = 1;
    if ( $fib->{$n} ) {
        return $fib->{$n};
    }
    $fib->{$n} = fib( $n - 1 ) + fib( $n - 2 );
}
