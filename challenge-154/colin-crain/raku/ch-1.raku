#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @pool = qw<  PELR  PREL  PERL  PRLE  PLER  
                PLRE  EPRL  EPLR  ERPL  ERLP  
                ELPR  ELRP  RPEL  RPLE  REPL  
                RELP  RLPE  RLEP  LPER  LPRE  
                LEPR  LRPE  LREP  >; 
my %pool =  @pool.Bag;

.say for
<PERL>  .comb
        .permutations
        .map({$_.join}) 
        .grep({ %pool{$_}:!exists })   
        
