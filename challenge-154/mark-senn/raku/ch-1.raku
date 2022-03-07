my @given =
'
PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP
'.comb(/<upper>+/);
my @computed = <P E R L>.permutations.map({.join});
(@computed (-) @given).keys.sort.join(' ').say;
