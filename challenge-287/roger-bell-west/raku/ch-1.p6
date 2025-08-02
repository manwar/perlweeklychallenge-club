#! /usr/bin/raku

use Test;

plan 5;

is(strongpassword('a'), 5, 'example 1');
is(strongpassword('aB2'), 3, 'example 2');
is(strongpassword('PaaSW0rd'), 0, 'example 3');
is(strongpassword('Paaasw0rd'), 1, 'example 4');
is(strongpassword('aaaaa'), 3, 'example 5');

sub strongpassword($a) {
    my %ctypes;
    my $reps = 0;
    my $rep = 0;
    my $old = '@';
    my @changes;
    my @chars = $a.comb;
    for @chars.kv -> $i, $c {
        if ($i > 0 && $c eq $old) {
            $rep += 1;
            if ($rep >= 2) {
                $reps += 1;
            }
        } else {
            $rep = 0;
            $old = $c;
        }
        my $t = 'n';
        if ($c ~~ /<upper>/) {
            $t = 'u';
        } elsif ($c ~~ /<lower>/) {
            $t = 'l';
        } elsif ($c ~~ /<digit>/) {
            $t = 'd';
        }
        %ctypes{$t}++;
    }
    @changes.push($reps);
    %ctypes{'n'}:delete;
    my $k = %ctypes.keys.elems;
    if ($k < 3) {
        my $spare = %ctypes.values.sum - $k;
        if ($spare < 0) {
            @changes.push(-$spare);
        }
    }
    if ($a.chars < 6) {
        @changes.push(6 - $a.chars);
    }
    return @changes.max;
}
