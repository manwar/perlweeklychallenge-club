#! /usr/bin/raku

use Test;

plan 5;

is-deeply(specialbinarysubstrings('0101'), ['01', '10', '01'], 'example 1');
is-deeply(specialbinarysubstrings('000111'), ['000111', '0011', '01'], 'example 2');
is-deeply(specialbinarysubstrings('000011'), ['0011', '01'], 'example 3');
is-deeply(specialbinarysubstrings('10011100'), ['10', '0011', '01', '1100', '10'], 'example 4');
is-deeply(specialbinarysubstrings('00000'), [], 'example 5');

sub specialbinarysubstrings($a) {
    my @out;
    my @ac = $a.comb;
    for 0 .. @ac.end - 1 -> $i {
        loop (my $j = $i + 1; $j <= @ac.end; $j += 2) {
            my $lastchar = 'x';
            my $switches = 0;
            my $balance = 0;
            my $outstr = '';
            for $i .. $j -> $ct {
                if (@ac[$ct] ne $lastchar) {
                    $switches += 1;
                    $lastchar = @ac[$ct];
                }
                if (@ac[$ct] eq '0') {
                    $balance--;
                } else {
                    $balance++;
                }
                $outstr ~= @ac[$ct];
            }
            if ($balance == 0 && $switches == 2) {
                @out.push($outstr);
            }
        }
    }
    @out;
}
