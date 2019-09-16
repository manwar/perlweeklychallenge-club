#!/usr/bin/perl
use strict;

# Create a script that accepts two strings, let us call it, “stones” and “jewels”. 
# It should print the count of “alphabet” from the string “stones” found in the string “jewels”. For example, 
# if your stones is “chancellor” and “jewels” is “chocolate”, then the script should print “8”. 
# To keep it simple, only A-Z,a-z characters are acceptable. Also make the comparison case sensitive

my $stones = shift || "chancellor";
my $jewels = shift || "chocolate";

$stones =~ s/[^a-zA-Z]//g;  
$jewels =~ s/[^a-zA-Z]//g;  

my $exp = join('|',split(//,$stones));
my $count = () = $jewels =~ /$exp/g;
print "$count\n";

__END__

./ch-1.pl
8

./ch-1.pl abcdefgh ijklmnop
0

./ch-1.pl abcdefgh abcd
4

./ch-1.pl abcdefgh aaaaahhhhh
10

