#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

my constant TEST = False;

#    ISBN-13 check or make the checksum.

class ISBN_13 { … };
#    NOTE: This only cares about the digits and the last hyphen.
#    Incorrect formating or noise is ignored and kept.
#    The following are accepted inputs and will be stored
#    as strings with the correct '-4' suffix:
#       '978905691538'
#       '978-90-569-1538'
#       '978-90-569-1538-'
#       '978-nondigit 90-569-1538-4'


my @Test =
    '978-nondigit 90-569-1538-' =>    '978-nondigit 90-569-1538-4',
    '978-nondigital garbage 90-569-1538-4' =>
        '978-nondigital garbage 90-569-1538-4',
    '978-nondigit 90-569-1538'   => '978-nondigit 90-569-1538-4',
    '9-7-8-0-9-1-4-9-4-1-8-2-8' => '9-7-8-0-9-1-4-9-4-1-8-2-8',
    '978-0-306-40615-7' => '978-0-306-40615-7',
    '978-0-306-40615'   => '978-0-306-40615-7',
    '978-1-449-32633-3' => '978-1-449-32633-3',
    '9789056915384'     => '978905691538-4',

    '000000000000'      => '000000000000-0',
    '100000000000'      => '100000000000-9',
    '001000000000'      => '001000000000-9',
    '000010000000'      => '000010000000-9',
    '000000100000'      => '000000100000-9',
    '000000001000'      => '000000001000-9',
    '000000000010'      => '000000000010-9',
    '010000000000'      => '010000000000-7',
    '000100000000'      => '000100000000-7',
    '000001000000'      => '000001000000-7',
    '000000010000'      => '000000010000-7',
    '000000000100'      => '000000000100-7',
    '000000000001'      => '000000000001-7',
    '131313131313'      => '131313131313-0',
    '030000000000'      => '030000000000-1',
    '030300000000'      => '030300000000-2',
    '030303000000'      => '030303000000-3',
    '030303030000'      => '030303030000-4',
    '030303030300'      => '030303030300-5',
    '030303030303'      => '030303030303-6',
;

sub MAIN ( ) {
    return if TEST;
    for '978-0-3non-num garbage 06-40615-7' -> $s {

        my $I = ISBN_13.from-Str: $s;
        say "\nISBN-13 check digit for "
          ~ "'978-0-3non-num-ish garbage06-40615-7' is $I.check-sum()."
    }
}

if TEST {
    use Test;
    plan 2 × @Test.elems;

    for @Test -> (:key($in), :value($exp)) {
        my $o = ISBN_13.from-Str( $in);
        is $o.check-sum, [$exp.comb].pop, "&isbn-checksum";
        is $o.Str, $exp, "&ISBN_13-from-Str -> $o.Str()";
    }
    done-testing;
}

class ISBN_13 {
    has Str $.isbn-with-checksum;

    method Str( --> Str ) { self.isbn-with-checksum; }

    method from-Str(Str $s where $s.chars ≥ 12) {

        my ($work, $return, $check);
        $work = $return = $s;
        $work ~~ s:g/ [ \D ] //;
        given $work.chars {
            when  13 {
                $work.=chop;
                $return.=chop;
            }
            when 12 { ; }
            default { die "Cannot make ISBN_13 from '$s'." }
        }
        $return = $return ~~ / '-' $/ ?? $return !! $return ~ '-';

        ISBN_13.new(
            :isbn-with-checksum($return ~ _make-isbn-checksum( $work)));
    }

    sub _make-isbn-checksum( Str $s --> Str ) {
        my $ret = (
            ([+] $s.comb[0, 2 … 10]) + ([+] 3 «*« $s.comb[1, 3 … 11])
        ) % 10;
        ( $ret == 0 ??  0 !! 10 - $ret
        ).Str;
    }

    method check-sum( --> Str) {
        $.isbn-with-checksum.comb[*-1].Str;
    }
}
