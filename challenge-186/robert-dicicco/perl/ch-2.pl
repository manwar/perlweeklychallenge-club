use strict;
use warnings;
use Text::Unidecode;
use utf8;

# AUTHOR: Robert DiCicco
# DATE: 2022-10-10
# Challenge 186 Unicode Makeover ( Perl )

my @arr = ("ÃÊÍÒÙ", "âÊíÒÙ");

for my $string (@arr) {

  print unidecode($string) . "\n";

}
