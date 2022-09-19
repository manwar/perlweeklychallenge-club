#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent;
use Test;
use Test-Ord;

=begin requirements
Task 1: Ordinal Number Spelling  Submitted by: Mohammad S Anwar

You are given a positive number, $n.
Write a script to spell the ordinal number.

=end requirements

=begin comment
I bave added Zeroeth because I often name one thing nothing.
Lingua::Number is broken
=end comment

sub MAIN( @n = ( 99943201, )) {
    for @n -> $n { say "$n -> ", ordinal( $n.Int); }
}

constant @cardinal = < Zero One Two Three Four Five Six
    Seven Eight Nine Ten Eleven Twelve Thirteen Fourteen
    Fifteen Sixteen Seventeen Eighteen Nineteen
    Twenty Twenty-One Twenty-Two Twenty-Three Twenty-Four
    Twenty-Five Twenty-Six Twenty-Seven Twenty-Eight Twenty-Nine
    Thirty Thirty-One Thirty-Two Thirty-Three Thirty-Four
    Thirty-Five Thirty-Six Thirty-Seven Thirty-Eight Thirty-Nine
    Forty Forty-One Forty-Two Forty-Three Forty-Four
    Forty-Five Forty-Six Forty-Seven Forty-Eight Forty-Nine
    Fifty Fifty-One Fifty-Two Fifty-Three Fifty-Four Fifty-Five
    Fifty-Six Fifty-Seven Fifty-Eight Fifty-Nine
    Sixty Sixty-One Sixty-Two Sixty-Three Sixty-Four Sixty-Five
    Sixty-Six Sixty-Seven Sixty-Eight Sixty-Nine
    Seventy Seventy-One Seventy-Two Seventy-Three Seventy-Four Seventy-Five
    Seventy-Six Seventy-Seven Seventy-Eight Seventy-Nine
    Eighty Eighty-One Eighty-Two Eighty-Three Eighty-Four Eighty-Five
    Eighty-Six Eighty-Seven Eighty-Eight Eighty-Nine
    Ninety Ninety-One Ninety-Two Ninety-Three Ninety-Four Ninety-Five
    Ninety-Six Ninety-Seven Ninety-Eight Ninety-Nine >;

constant TEST=True;
if TEST {
    plan @Test-Cardinal.elems + @Test-Ordinal + %Test-Ordinal.keys;

    for @Test-Cardinal -> @t { is cardinal( @t[0]), @t[1]; }
    for @Test-Ordinal -> @t { is ordinal( @t[0]), @t[1]; }
    for %Test-Ordinal.keys -> $k { is ordinal( $k), %Test-Ordinal{$k}[0]; }

    done-testing;
    exit;
}

# Create a cardinal phrase name for an pos. Int
sub cardinal( Int $n is copy where * ≥ 0 --> Str) {
    return 'Zero' if $n == 0;

    my @triad = $n.Str.flip.comb( 3).reverse;
    @triad.=map: *.flip;
    my $period = @triad.end;
    my $ret;

    while @triad {
        $ret ~= _generation( @triad.shift.Str, $period--);
    }
    return $ret.=trim-trailing;
}

# Create the ordinal phrase for 3 digits: hundreds, tens, ones, with suffix.
sub _generation( Str $digits is copy, $period) {

    constant @suffix =  ' ', ' Thousand ', ' Million ', ' Billion ',
        ' Trillion ', ' Quadrillion ', ' Quintillion ', ' Sextillion ',
        ' Septillion ', ' Octillion ';

    $digits.=subst: / ^ 0 + / ;
    return '' if $digits eq '';

    return @cardinal[ $digits] ~ @suffix[$period] if $digits < 100;
    my $h = @cardinal[ $digits.substr( 0, 1)] ~ ' Hundred';
    return $h  ~ @suffix[$period] if '00' == $digits.substr( 1, 2);
    return $h ~= " " ~ @cardinal[ $digits.substr( 1, 2)] ~ @suffix[$period];
}

# Convert a cardinal number's name-phrase to ordinal.
sub ordinal( $n --> Str) {
    my $ret = cardinal( $n.Int);

    constant  %suffix = One => 'First', Two => 'Second', ree => 'ird',
        ive => 'ifth',  ght => 'ghth', ine => 'inth',    lve => 'lfth',
        ety => 'etieth', fty => 'ftieth', hty => 'htieth', nty => 'ntieth',
        rty => 'rtieth', xty => 'xtieth',
        red => 'redth',  and => 'andth', ion => 'ionth', ero => 'eroeth';

    if %suffix{ $ret.substr($ret.chars -3)}:exists {
        $ret.substr-rw($ret.chars -3) = %suffix{$ret.substr( $ret.chars -3 )};
        return $ret;
   } 
   return $ret ~ 'th';
}
