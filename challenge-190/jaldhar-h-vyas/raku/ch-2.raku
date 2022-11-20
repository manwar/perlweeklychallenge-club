#!/usr/bin/raku

sub MAIN(
    Str $s #= a string of digits
) {
    my @combos;

    @combos.push($s.comb);
    @combos.push($s.comb(2));

    for 0 ..^ $s.chars - 1  -> $n {
        my @chars = $s.comb;
        @chars.splice($n, 2, @chars[$n,$n + 1].join);
        @combos.push(@chars);
    }

    my %results;

    for @combos -> $combo {
        unless @$combo.grep({ $_ < 1 || $_ > 26 }).elems {
            %results{$combo.map({ ('A' .. 'Z')[$_ -1] }).join}++;
        }
    }

    %results.keys.sort.join(q{, }).say;
}