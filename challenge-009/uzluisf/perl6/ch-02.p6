#!/usr/bin env perl6
use lib '.';
use ModuleCH02;

sub MAIN( 
    *@scores where *.elems > 0,    #= Items to be ranked
    Str :r(:$ranking) = "standard" #=«Ranking to be used.
                                      Options: standard, modified and dense.
                                      Default: standard»
) {

    unless $ranking ∈ <standard modified dense> {
        note "Please provide an appropriate ranking option. " ~
             "See '$*PROGRAM -h' for help.";
        return;
    }

    my @rankings = do given $ranking {
        when 'standard' { ranking @scores            }
        when 'modified' { ranking @scores, :modified }
        when 'dense'    { ranking @scores, :dense    }
    }

    put 'Rankings: ', @rankings.join('–');
}
