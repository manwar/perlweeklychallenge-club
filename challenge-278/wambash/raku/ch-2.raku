#!/usr/bin/env raku

sub reverse-word ($str, :$char) {
    $str.subst(
        / (.)*? <after $char> /,
        { [~] .[0].sort }
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-word('challenge', :char<e>), 'acehllnge';
    is reverse-word('programming', :char<a>), 'agoprrmming';
    is reverse-word('champion', :char<b>), 'champion';
    done-testing;
}

multi MAIN ($str,:$char) {
    say reverse-word $str,:$char
}
