#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Bool :s(:$standard),
    Bool :m(:$modified),
    Bool :d(:$dense),
    *@STRINGS-TO-RANK,
    ) {    
    say (($modified) ?? (&modified)
     !! (($dense) ?? (&dense) !! (&standard))).( @STRINGS-TO-RANK )
}

sub standard(@a) { @a.sort.antipairs.classify({ $_.key }).values.map(*.min).sort({ $_.key }) }

sub modified(@a) { @a.sort.antipairs.classify({ $_.key }).values.map(*.max).sort({ $_.key }) }

sub dense(@a) { @a.Set.keys.sort.antipairs }
