#!raku

#
# Perl Weekly Challenge 227
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
#

sub rom-to-num($r) {
    [+] gather $r.uc ~~ /
        ^
        [
        | M  { take 1000 }
        | CM { take 900 }
        | D  { take 500 }
        | CD { take 400 }
        | C  { take 100 }
        | XC { take 90 }
        | L  { take 50 }
        | XL { take 40 }
        | X  { take 10 }
        | IX { take 9 }
        | V  { take 5 }
        | IV { take 4 }
        | I  { take 1 }
        ]+
        $
    /;
}


my %symbols =
    1 => 'I',
    4 => 'IV',
    5 => 'V',
    9 => 'IX',
    10 => 'X',
    40 => 'XL',
    50 => 'L',
    90 => 'XC',
    100 => 'C',
    400 => 'CD',
    500 => 'D',
    900 => 'CM',
    1000 => 'M'
;

sub arabic-to-roman( $number ) {
    return ''  if $number == 0;

    for %symbols.keys.sort( { $^b <=> $^a } ) {
	if $number >= $_ {
	    return %symbols{ $_ } ~ arabic-to-roman( $number - $_ );
	}
    }

}

sub MAIN( *@s where { @s.elems == 3 } ) {

    my @operands = rom-to-num( @s[ 0 ] ), rom-to-num( @s[ 2 ] );
    my $result;
    given ( @s[ 1 ] ) {
	when '+' { $result = [+] @operands; }
	when '-' { $result = [-] @operands; }
	when '*' { $result = [*] @operands; }
	when '/' { $result = [/] @operands; }

    }

    exit if $result <= 0;
    say arabic-to-roman( $result );
}
