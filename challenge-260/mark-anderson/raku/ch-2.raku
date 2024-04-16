#!/usr/bin/env raku
use experimental :cached;
use Test;

#
# With help from https://www.youtube.com/watch?v=-MpL0X3AHAs
#

is rank('cat'),                                                                                3, 'cat';
is rank('secret'),                                                                           255, 'secret';
is rank('google'),                                                                            88, 'google';
is rank('mississippi'),                                                                    13737, 'mississippi';
is rank('1100010001100001111100000010101010001101111111111100101011100001'), 1340132963011393299, '64 bits';

sub postfix:<!>($n) is cached { [*] 1..$n }

sub rank($word)
{
    my @w = $word.comb;
    my @ranks = @w.sort.squish.antipairs.Map{@w}; 
    my $bag = @ranks.BagHash;

    my @n = gather for @ranks -> $r
    {
        my @less-than = $bag.keys.grep(* < $r);
        take ([+] $bag{@less-than}) / ([*] $bag.values>>!).FatRat;
        $bag{$r}--
    }
        
    1 + [+] @n Z* (@ranks.end...0)>>!
}
