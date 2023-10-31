#!/usr/bin/env raku

sub acronym (+str, :$chk) {
    str
    andthen .map: *.substr: 0,1
    andthen .join.fc eq $chk
}

multi MAIN (Bool :test($)!) {
    use Test;
    is acronym('Perl','Python','Pascal', :chk<ppp>),True;
    is acronym('Perl','Raku', :chk<rp>), False;
    is acronym('Raku','Perl', :chk<rp>), True;
    is acronym('Oracle','Awk', 'C', :chk<oac>), True;
    done-testing;
}

multi MAIN (+str, :$chk) {
    say acronym str, :$chk
}
