use v6;

# Author: Robert DiCicco
# Date: 28-FEB-2022
# Challenge #153 Missing Permutation ( Raku )

my @given = ("PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR", "ERPL",
 "ERLP", "ELPR", "ELRP", "RPEL", "RPLE", "REPL", "RELP", "RLPE", "RLEP",
 "LPER", "LPRE", "LEPR", "LRPE", "LREP",);

my @p = 'PERL'.comb;

for @p.permutations.sort {
  my $val = $_;
  $val ~~ s:g/\s+//;
  if ( $val (elem) @given ) == False {
    say $val ~ ' Not Found in supplied list';
  }
}
