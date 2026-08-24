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
    my $a = [~] '01' xx $n;
    my $b = [~] '0'  x  $n, '1' x $n; 

    return ($a.parse-base(2)...$b.parse-base(2))
                                 .fmt('%0' ~ $n*2 ~ 'b')
                                 .trans('01' => 'UD')
                                 .split(' ')
                                 .grep(all *.ends-with('D'), *.comb('D') == $n, &f);

    sub f($_)
    {
        ? none do for .flip ~~ m:ov/...*/ -> $m 
        { 
            .<D> > .<U> given $m.comb.Bag
        }
    }
}
