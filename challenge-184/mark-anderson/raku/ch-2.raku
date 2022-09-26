#!/usr/bin/env raku

say split-array('a 1 2 b 0', '3 c 4 d');
say split-array('1 2', 'p q r', 's 3', '4 5 t');

sub split-array(+$list)
{
    my $loh := $list.map({ .comb(/\S/)
                           .classify({ /<lower>/ ?? 'letters' !! 'numbers' }) 
                         }).cache;

    $loh.map({ .<numbers> if .<numbers> }),
    $loh.map({ .<letters> if .<letters> })
}
