#! /usr/bin/raku

use Test;

plan 5;

is-deeply(alternatingvowelsconsonants(['relocate', 'delocate', 'allocate']), ['locate'], 'example 1');
is-deeply(alternatingvowelsconsonants(['apple', 'banana', 'cherry']), [], 'example 2');
is-deeply(alternatingvowelsconsonants(['navigate', 'cavity', 'gravity']), ['avi'], 'example 3');
is-deeply(alternatingvowelsconsonants(['pedalgia', 'pedalboard', 'pedantic']), ['peda'], 'example 4');
is-deeply(alternatingvowelsconsonants(['schoolmaster', 'schoolhouse', 'schooling']), ['ho', 'ol'], 'example 5');

sub common_substring(@a0) {
    my @a = @a0.sort({$^a.chars <=> $^b.chars});
    my @results;
    for (1 .. @a[0].chars - 1).reverse -> $l {
        for 0 .. @a[0].chars - $l -> $offset {
            my $m = True;
            my $sample = @a[0].substr($offset, $l);
            for 1 .. @a.end -> $axi {
                with @a[$axi].index($sample) -> $le {
                    ;
                } else {
                        $m = False;
                        last;
                    }
            }
            if ($m) {
                @results.push($sample);
            }
        }
    }
    @results;
}

sub is_avc($a) {
    my $valid = True;
    my $laststate = True;
    for $a.comb.kv -> $i, $c {
        my $thisstate;
        given $c {
            when 'a' | 'e' | 'i' | 'o' | 'u' {
                $thisstate = True;
            }
            default {
                $thisstate = False;
            }
        }
        if ($i > 0 && $thisstate == $laststate) {
            $valid = False;
            last;
        }
        $laststate = $thisstate;
    }
    $valid;
}

sub alternatingvowelsconsonants(@a) {
    my @candidates = common_substring(@a);
    my @c2 = @candidates.grep({is_avc($_)});
    if (@c2.elems > 0) {
        my $l = @c2[0].chars;
        return @c2.grep({$_.chars == $l}).Array;
    } else {
        return [];
    }
}
