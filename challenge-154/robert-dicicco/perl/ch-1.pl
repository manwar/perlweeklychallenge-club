#!perl.exe

use strict;
use warnings;
use feature qw/say/;
use Algorithm::Permute;

# Author: Robert DiCicco
# Date: 28-FEB-2022
# Challenge #154 Missing Permutation ( Perl )

my @given = qw( PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
            ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
            LPER LPRE LEPR LRPE LREP
            );

my @p = split(//,'PERL');
my $x = Algorithm::Permute->new(\@p);

while (my @res = $x->next) {
  my $val = join("", @res);
  my $retval = grep( /$val/, @given);
  if ( ! $retval){
     print "$val Not Found in given list\n";
  }
}
