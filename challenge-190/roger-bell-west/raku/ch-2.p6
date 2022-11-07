#! /usr/bin/perl6

use Test;

use MONKEY-SEE-NO-EVAL;

plan 3;

is-deeply(decodedlist("11"), ["AA", "K"], 'example 1');
is-deeply(decodedlist("1115"), ["AAAE", "AAO", "AKE", "KAE", "KO"], 'example 2');
is-deeply(decodedlist("127"), ["ABG", "LG"], 'example 3');

sub decodedlist($s) {
    my @stack;
    @stack.push([$s]);
    my $out = SetHash.new;
    while (True) {
        my $ent = @stack.shift;
        my $tail = $ent.pop;
        if ($tail.chars == 0) {
            $out{$ent.raku} = True;
        } else {
            if (substr($tail, 0, 1) ne "0") {
                my $q = $ent.clone;
                $q.push(substr($tail, 0, 1));
                $q.push(substr($tail, 1));
                @stack.push($q);
            }
            if ($tail.chars >= 2) {
                my $v = 0 + substr($tail, 0, 2);
                if ($v >= 1 && $v <= 26) {
                    my $q = $ent.clone;
                    $q.push(substr($tail, 0, 2));
                    $q.push(substr($tail, 2));
                    @stack.push($q);
                }
            }
        }
        if (@stack.elems == 0) {
            last;
        }
    }
    my @k;
    my $alphazero = ord("A") - 1;
    for $out.keys -> $x {
        @k.push(EVAL($x).map({chr($alphazero + $_)}).join(""));
    }
    return Array(@k.sort);
}
