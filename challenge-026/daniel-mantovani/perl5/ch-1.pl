# Create a script that accepts two strings, let us call it, “stones” and “jewels”.
# It should print the count of “alphabet” from the string “stones” found in the
# string “jewels”. For example, if your stones is “chancellor” and “jewels” is
# “chocolate”, then the script should print “8”. To keep it simple, only A-Z,a-z
# characters are acceptable. Also make the comparison case sensitive.

use strict;
use warnings;
use v5.20;

# let's read the two strings from command line
my ( $stones, $jewels ) = @ARGV;

my $n = 0;

# we just count the times each char from $stones exists in $jewels

$n += $jewels =~ /$_/ for split '', $stones;

# and I think that's it, unless I misunderstood the challenge (which is very likely)

say "$stones letters found in $jewels are $n in total";
