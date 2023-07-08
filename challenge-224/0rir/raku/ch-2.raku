#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
224-2: Additive Number          Submitted by: Mohammad S Anwar
Given a string containing digits 0-9 only, find if the given string is an
additive number. An additive number is one whose digits form an additive
sequence.
    A valid additive sequence should contain at least 3 numbers. Except the
first 2 numbers, each subsequent number in the sequence must be the sum of
the preceding two.

Example 1:
Input: $string = "112358"
Output: true

The additive sequence can be created using the given string digits: 1,1,2,3,5,8
1 + 1 => 2
1 + 2 => 3
2 + 3 => 5
3 + 5 => 8
Example 2:
Input: $string = "12345"
Output: false

No additive sequence can be created using the given string digits.
Example 3:
Input: $string = "199100199"
Output: true

The additive sequence can be created using the given string digits: 1,99,100,199
 1 +  99 => 100
99 + 100 => 199

=end comment

my @Test =
            # simple special case
=begin comment
=end comment
    "0 0 0",                False,
    "000000000000000000",   False,
    "1",                    False,
    "12",                   False,
            # ill-formed
    "012",                  False,
    "01123",                False,
    "00001123",             False,
            # fouled
    "1203",                 False,
    "222 555 0777 1332",    False,
            # Insolvable
    "12345",                False,
    "112336",               False,
           #
    "1 99 100 199",         True,
    "1 1 2 3 5 8",          True,
    "224 466 690 1156",     True,
    '5510 234 5744 5978',   True,
    '123 123 246 369',      True,
    "11 23 34",             True,
    (10,23, *+*…* > 10¹⁰).join,        True,
    (1238,111, *+*…* > 10¹⁰).join,     True,
;

plan @Test ÷ 2;

sub zed-fouled( $str -->Bool) { $str.starts-with('0') and +$str ≠ 0 }

sub first-three( $a -->Array) {
    my @return;
    my $a-len = $a.chars;
  ONE:
    for 1..$a-len -> $i {
        my $one = $a.substr( 0, $i);
        next if zed-fouled( $one);                          # No leading zeds.
  TWO:  for 1..($a-len - $i -1 ) -> $ii {
            my $two = $a.substr( $i, $ii);
            next TWO if zed-fouled( $two);                  # No leading zeds.
            my $three = ~( $one + $two);
            if $three eq $a.substr( $i+$ii, $three.chars) {
                my $tail = $a.substr( $i+$ii+$three.chars);
                                                            # No leading zeds.
                next TWO if $tail.starts-with('0') and $three > 0;
                @return.push: [ $two, $three, $tail];
            }
        }
    }
    return @return;
}

sub the-rest( @aoa -->Bool) {
  FOR:
    for @aoa -> @a {
        my ( $deuce, $trey, $tail ) = @a;
        return True if $tail eq '';                     # Triplet only.
        while $tail {
            my $next = ~($deuce + $trey);
            if $next eq $tail.substr( 0, $next.chars) {
                $tail ~~ s/ ^ $next//;
                if $tail eq '' {
                    return True
                }
                $deuce = $trey;
                $trey = $next;
                next;
            } else {
                next FOR;
            }
        }
    }
    return False;
}

sub additive( $s -->Bool){
    my $s-len = $s.chars;
    return False if $s-len < 3;
    return False if $s.starts-with: '0';
    return the-rest( first-three( $s));
}

for @Test -> $in, $r {
    my $s = $in.subst: ' ', '', :g ;
    is additive($s), $r, "$r <- $in";
}
done-testing;

my $string = "2244666901156";
say "\nInput: \$string = $string\n Output: ", additive( $string);

exit;

