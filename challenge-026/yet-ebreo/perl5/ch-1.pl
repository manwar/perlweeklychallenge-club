# Create a script that accepts two strings, let us call it, “stones” and “jewels”. 
# It should print the count of “alphabet” from the string “stones” found in the string “jewels”. 
# For example, if your stones is “chancellor” and “jewels” is “chocolate”, then the script should print “8”. 
# To keep it simple, only A-Z,a-z characters are acceptable. Also make the comparison case sensitive.
use strict;
use warnings;
use v5.10;

die "Usage:\n\tch-1.pl <string1> <string2>\n\n" if @ARGV < 2;
die "Only A-Z and a-z characters are allowed\n\n" if 0+grep /[^A-Za-z]/, @ARGV;

say eval "\$ARGV[1]=~y/$ARGV[0]//";

# perl .\ch-1.pl chancellor chocolate
# 8