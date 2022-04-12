use v6;

use Lingua::EN::Numbers;

# AUTHOR: Robert DiCicco
# DATE: 11-APR-2022
# Challenge 160 Four Is Magic ( Raku )

sub MAIN ( Int $n is copy ) {
  print "Input: \$n = $n\n";

  while ( $n != 4 ) {
    my $n_len = cardinal($n).chars;
    print tclc(cardinal($n)) ~ " is " ~ tclc(cardinal($n_len)) ~ ", ";
    $n = $n_len;
  }

  say "Four is magic.";
}
