#!/usr/bin/env raku
use Test;

is-deeply rank-score(<1 2 4 3 5>),     <5 4 S B G>>>.Str;
is-deeply rank-score(<8 5 6 7 4>),     <G 4 B S 5>>>.Str;
is-deeply rank-score(<3 5 4 2>),       <B G S 4>>>.Str;
is-deeply rank-score(<2 5 2 1 7 5 1>), <B S B 4 G S 4>>>.Str;
is-deeply rank-score(<3 5>),           <S G>;

sub rank-score($a)
{
    my $u := $a.unique.sort(-*);
    my $s := <G S B 4 5>...*;

    $a.trans($u => $s.head($u)).comb(/<alnum>/)
}
