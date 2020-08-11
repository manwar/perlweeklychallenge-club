#Write a script that dumps its own source code. 
#For example, say, the script name is ch-2.pl then the following command should returns nothing.
#perl ch-2.pl | diff - ch-2.pl

use strict;
use warnings;

open (my $fh_file , '<', $0 ) or die "Error reading file";
while (my $line = <$fh_file>){
     print $line;
}
close ($fh_file);