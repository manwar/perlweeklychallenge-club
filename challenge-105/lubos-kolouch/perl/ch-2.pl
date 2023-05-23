use strict;
use warnings;

sub name_game {
    my $name         = shift;
    my $rest_of_name = substr $name, 1;
    print "$name, $name, bo-b$rest_of_name,\n";
    print "Bonana-fanna fo-f$rest_of_name\n";
    print "Fee fi mo-m$rest_of_name\n";
    print "$name!\n";
}

name_game('Katie')
  ; # Output: Katie, Katie, bo-batie, Bonana-fanna fo-fatie, Fee fi mo-matie, Katie!
