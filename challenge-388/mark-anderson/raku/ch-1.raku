#!/usr/bin/env raku
use Test;

is-deeply dyck-words(1), ("UD",);
is-deeply dyck-words(2), <UDUD UUDD>;
is-deeply dyck-words(3), <UDUDUD UDUUDD UUDDUD UUDUDD UUUDDD>;
is-deeply dyck-words(0), Empty;
is-deeply dyck-words(4), <UDUDUDUD UDUDUUDD UDUUDDUD UDUUDUDD UDUUUDDD
                          UUDDUDUD UUDDUUDD UUDUDDUD UUDUDUDD UUDUUDDD
                          UUUDDDUD UUUDDUDD UUUDUDDD UUUUDDDD>;

multi dyck-words($n where * < 1) { Empty }

multi dyck-words($n)
{
    my @c = (^($n*2)).combinations($n);
    my $i = @c.first((1,3...^($n*2)).cache, :k:end);
    @c = @c[$i..*];

    return @c.hyper.map(&f).List;

    sub f(@a)
    {
        my (@b, @s);
        @b[@a] = -1 xx $n;
        @s = (^($n*2) (-) @a).keys;
        @b[@s] = 1 xx $n;
        @b.trans((1,-1) => ('U','D'))
          .subst(' ', :g) if ([\+] @b).all >= 0
    }
}

multi dyck-words-v2($n where * < 1) { Empty }

multi dyck-words-v2($n)
{
    my $a = ([~] '10' xx $n).parse-base(2);
    my $b = ([~] '1'  x  $n, '0' x $n).parse-base(2); 

    return ($a,$a+2...$b).hyper.map(&f).List;

    sub f($_) 
    {
        my $b = .base(2);
        my @a = $b.subst('0', '-1', :g).comb(/'-'? 1/);
        my @s = [\+] @a;
        $b.trans('10' => 'UD') if all @s.tail == 0, @s.all >= 0
    }
}
