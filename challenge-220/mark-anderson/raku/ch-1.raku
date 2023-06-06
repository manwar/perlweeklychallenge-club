#!/usr/bin/env raku
use Test;

is-deeply common-characters(<Perl Rust Raku>),  ("r",);
is-deeply common-characters(<love live leave>), <e l v>;

sub common-characters
{
    sort .keys given [(&)] @^a>>.lc>>.comb 
}
