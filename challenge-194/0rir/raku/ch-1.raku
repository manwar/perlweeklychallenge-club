#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
194-1: Digital Clock                Submitted by: Mohammad S Anwar
Given time in the format hh:mm with one missing digit.  Find the highest
digit between 0-9 that makes it valid time.

Example 1
Input: $time = '?5:00'
Output: 1

Since 05:00 and 15:00 are valid time and no other digits can fit in
the missing place.
Example 2
Input: $time = '?3:00'
Output: 2
Example 3
Input: $time = '1?:00'
Output: 9
Example 4
Input: $time = '2?:00'
Output: 3
Example 5
Input: $time = '12:?5'
Output: 5
Example 6
Input: $time =  '12:5?'
Output: 9
=end comment

# Fix the malformed time to the latest time possible.
sub extra( Str:D $t --> Str ) {
    my $i = tick-tock( $t) ;
    return $t.subst( /'?'/, $i );
}

# Return the digit which makes the string the latest time possible.
sub tick-tock( Str:D $t --> Int ) {
    my $s;
    given $t {
        when m/ '?' \d ':' \d \d / {
            $s = $t.substr( 1,1 ).Int;
            when $s == 4 and $t.substr(3).Int == 0 { return 2 }
            when $s > 3 { return 1 }
            when $s ≤ 3 { return 2 }
        }
        when m/ \d '?' ':' \d \d / {
            $s = $t.substr( 0,1 ).Int;
            when $s ≠ 2 { return 9 }
            when $s == 2 and $t.substr(3).Int == 0 { return 4 }
            return 3;
        }
        when m/ \d \d ':' '?' \d / { return 5; }
        when m/ \d \d ':' \d '?' / { return 9; }

        default { die 'Input is not broken correctly'; }
    }
}

multi MAIN ( 'test') {
    my @Test =
        { in =>  '?0:00',  exp => '20:00', },
        { in =>  '?3:00',  exp => '23:00', },
        { in =>  '?4:00',  exp => '24:00', },
        { in =>  '?4:01',  exp => '14:01', },
        { in =>  '?5:00',  exp => '15:00', },
        { in =>  '0?:00',  exp => '09:00', },
        { in =>  '1?:00',  exp => '19:00', },
        { in =>  '2?:00',  exp => '24:00', },
        { in =>  '2?:09',  exp => '23:09', },
        { in =>  '23:?0',  exp => '23:50', },
        { in =>  '23:0?',  exp => '23:09', },
    ;
    my @die = '?3:0?',;

    plan 1 + @Test;
    for @die -> $s {
        dies-ok { tick-tock( $s ) }, 'Dies on malformed input.';
    }
    for @Test -> %t {
        is extra( %t<in>), %t<exp>, " %t<in> -> %t<exp>";
    }
    done-testing;
    exit;
}

multi MAIN( Str $in = "?4:01") {
say "Input: \$time = '?4:01'
Output: ", tick-tock($in);
}


