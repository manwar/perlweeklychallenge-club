#! /usr/bin/raku

use Test;

plan 3;

is(completingword('aBc 11c', ['accbbb', 'abc', 'abbc']), 'accbbb', 'example 1');
is(completingword('La1 abc', ['abcl', 'baacl', 'abaalc']), 'baacl', 'example 2');
is(completingword('JB 007', ['jj', 'bb', 'bjb']), 'bjb', 'example 3');

sub str2hash($a) {
    my %m;
    for $a.comb -> $c {
        if ($c ~~ /<alpha>/) {
            %m{$c.lc}++;
        }
    }
    return %m;
}

sub completingword($a, @cw) {
    my %ah = str2hash($a);
    my @out;
    for @cw -> $t {
        my $valid = True;
        my %th = str2hash($t);
        for %ah.kv -> $k, $v {
            unless (%th{$k}:exists) {
                $valid = False;
                last;
            }
            if (%th{$k} < $v) {
                $valid = False;
                last;
            }
        }
        if ($valid) {
            @out.push($t);
        }
    }
    if (@out.elems == 0) {
        return "";
    }
    return (@out.sort({$^a.chars <=> $^b.chars}))[0];
}
