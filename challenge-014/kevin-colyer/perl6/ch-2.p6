#!/usr/bin/perl6
use v6;

use Test;

my @words="/usr/share/dict/words".IO.lines.map(*.lc.trans('\'' => '', :delete, 'éåö' => 'eao').uc).grep(*.chars > 3) ;
say "Longest word is: " ~ wordsearch(@words);
# CAMPINAS

sub wordsearch(@words) {
    my @codes=<AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA AL ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY AS GU MP PR VI FM MH PW AA AE AP CM CZ NB PI TT>.sort;
    my $best="";

    for @words -> $word {
        my $found=True;
        for $word.comb(2) -> $xx {
            if not ( $xx (elem) @codes ) {
                $found=False;
                last;
            };
        }
        if $found {
            #say "> Found $word";
            $best=$word if $word.chars>$best.chars ;
        }
    }
    return $best;
}
