#run like: perl ch-2.pl
#run like: perl ch-2.pl âÊíÒÙ
#run like: perl ch-2.pl æøå ÆØÅ
#run like: perl ch-2.pl '\x{5317}\x{4EB0}'
#run like: perl ch-2.pl '\N{DROMEDARY CAMEL}' '\N{MONKEY}'
#run like: perl ch-2.pl 🐪 🐒

use utf8;
use Text::Unidecode;    # ubuntu: sudo apt install libtext-unidecode-perl

my @input = @ARGV
          ? eval"(".join(',',map qq("$_"),@ARGV).")"
          : 'âÊíÒÙ';

no warnings 'utf8';     # suppress "Wide character in say at..."
print "$_ →  ", unidecode($_), "\n" for @input;
