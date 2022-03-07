#! /usr/bin/env raku

unit sub MAIN (:s(:$string)       = 'PERL',
               :p(:$permutations) = "PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
                                     ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
                                     LPER LPRE LEPR LRPE LREP",
               :v(:$verbose));
	  
my %permuations = $permutations.words.Set;

my @missing;

for $string.comb.permutations>>.join -> $candidate
{
  say ": Checking candidate: $candidate" if $verbose;
  @missing.push: $candidate unless %permuations{$candidate};
}

say @missing.unique.join(", ") if @missing;
