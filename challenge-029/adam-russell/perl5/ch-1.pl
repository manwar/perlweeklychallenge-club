use strict;
use warnings;
##
# Write a script to demonstrate brace expansion.
##
my $statement = "@ARGV";
$statement =~ m/(.*)\{(.*)\}(.*)/;
for my $brace (split(/,/, $2)){
    print "$1$brace$3\n";
}
