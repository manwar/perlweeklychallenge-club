use strict;
use warnings;
##
# Create a script which takes a list of numbers from command line and print 
# the same in the compact form. For example, if you pass "1,2,3,4,9,10,14,15,16" then 
# it should print the compact form like “1-4,9,10,14-16”.
##
use Data::Dump q/pp/;
my @a = split(/\,/, $ARGV[0]);
my $a = pp @a;
$a =~ s/\.{2}/-/g;
$a =~ tr/( )//d;
print "$a\n";  
