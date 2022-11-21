#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use List::Util qw{ uniq };
# use Memoize;
# memoize('test');

# before Memoize:
# real    0m30.866s
# user    0m10.766s
# sys     0m1.016s

# after Memoize:
# real    1m28.003s
# user    0m30.375s
# sys     0m1.672s

# to check your work: https://oeis.org/A320843

my @input = 1 .. 15;
for my $i (@input) {
    my @list = cute_list($i);
    my $list = join ",\n\t", @list;
    say <<"END";
    Input:  \$s = $i
    Output: $list
END
}

sub cute_list ( $input ) {
    my $n;
    $n->@* = 1 .. $input;
    my @output = permute($n);
    return scalar grep { defined } @output;
}

# this looks like a job for recursion!
sub permute ( $remaining, $numbers = [] ) {
    state $hash;
    my @output;
    if ( !scalar $remaining->@* ) {

        # say join ' ', $numbers->@*;
        return 1;
    }
    my $i = 1 + scalar $numbers->@*;
    for my $r ( $remaining->@* ) {
        next unless test( $i, $r );
        my $rremaining->@* = grep { $_ != $r } $remaining->@*;
        my $nnumbers->@*   = ( $numbers->@*, $r );
        push @output, permute( $rremaining, $nnumbers );
    }
    return @output;
}

sub test ( $i, $j ) {
    ( $i, $j ) = sort $i, $j;
    return 0 == $i % $j || 0 == $j % $i ? 1 : 0;
}

# the call to pre-existing wheels is great. I hopped on the idea of
# having Algorithm::Permute take the wheel was powerful, but the problem
# is that it returns all the choices with no discernable order, so if you
# know, for example, that a value won't fit in the 2nd position, then you
# can eliminate every choice with that, turning this from an exponential
# problem into one that's much more solvable.

# which is to say that this is correct but unneccessarily slow.
sub cute_list_slow ( $input ) {
    my @output;
    my @list = 1 .. $input;
    my $p    = Algorithm::Permute->new( \@list );
    while ( my @arr = $p->next ) {
        my @copy = @arr;
        unshift @arr, 0;
        my $c = 0;
        for my $i ( 1 .. -1 + scalar @arr ) {
            my $j = $arr[$i];
            next unless 0 == $i % $j || 0 == $j % $i;
            $c++;
        }
        push @output, join ', ', @copy if $c == $input;
    }
    return scalar @output;
    return map { qq{[$_]} } sort @output;
}

