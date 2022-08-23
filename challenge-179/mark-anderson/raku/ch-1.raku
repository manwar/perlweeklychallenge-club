#!/usr/bin/env raku
use Test;

is ordinal(11),       'eleventh';
is ordinal(62),       'sixty-second';
is ordinal(99),       'ninety-ninth';
is ordinal(100),      'one-hundredth';
is ordinal(4320),     'four thousand, three-hundred-twentieth';
is ordinal(11009029), 'eleven million, nine thousand, twenty-ninth';

multi ordinal($n where * ~~ UInt)
{
    ordinal(number2string($n))
}

multi ordinal($s)
{
    my $ord;

    my %h = :one('first'),    :two('second'), :three('third'), :five('fifth'), 
            :eight('eighth'), :nine('ninth'), :twelve('twelfth');

    my $m = $s ~~ / <[a..z]>+ $ /;

    given $m
    {
        when %h{$_}:exists   { $ord = %h{$m} }
        when .ends-with('y') { $ord = $m.subst(/ y $ /, 'ieth') }
        default              { $ord = $m ~ 'th' }
    }

    $s.subst(/ $m $ /, $ord);
}

sub number2string($num)
{
    my @n = $num.polymod(1000 xx *);

    my @lt-twenty = < one two three four five six seven eight nine ten eleven twelve 
                      thirteen fourteen fifteen sixteen seventeen eighteen nineteen > andthen .unshift: '';

    my @tens = < twenty thirty forty fifty sixty seventy eighty ninety > andthen .prepend: '', '';

    my @magnitude = < thousand million billion trillion quadrillion quintillion > andthen .unshift: '';

    return .reverse.join(', ') given gather for @n.kv -> $k, $v
    {
        given $v.chars
        {
            when 1 { take (@lt-twenty[$v] ~ ' ' ~ @magnitude[$k]).trim-trailing if $v }
            when 2 { take (lt-hundred($v) ~ ' ' ~ @magnitude[$k]).trim-trailing }
            default 
            {
                my $h = @lt-twenty[$v.substr(0,1)] ~ '-hundred';
                my $t = lt-hundred($v.substr(1,2));
                take (not $t) ?? $h !! ($h ~ '-' ~ $t ~ ' ' ~ @magnitude[$k]).trim-trailing; 
            }
        }
    }

    sub lt-hundred($n)
    {
        return @lt-twenty[$n] if $n < 20;
        my @d = $n.comb;
        return @tens[@d[0]] unless +@d[1]; 
        return @tens[@d[0]] ~ '-' ~ @lt-twenty[@d[1]]
    }
}
