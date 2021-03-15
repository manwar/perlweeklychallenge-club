#Create a script that generates Pascal Triangle. Accept number of rows from the
#command line. The Pascal Triangle should have at least 3 rows.

use strict;
use warnings;

#Using the formula of Pascal's triangle. (nCk)

my $rowsnumber = $ARGV[0];

if($rowsnumber < 3){ 
   print "At least 3 rows!";
}

$rowsnumber--; #Switching to zero index because computers

my $colnumber = 0;

my @pascaltriangle = ();

sub fact {
    my $arg = shift;
    my $result = 1;
    while($arg != 0) {
        $result *= $arg;
        $arg--;
        }
    return $result;
}

foreach my $rowiter (0 .. $rowsnumber) {
    my $col = [];
    while ($colnumber <= $rowiter) { 
        @$col[$colnumber] = fact($rowiter)/(fact($colnumber) * fact($rowiter - $colnumber)); 
        $colnumber++;
    }
    $colnumber = 0;
    @pascaltriangle[$rowiter] = $col;
 }


#Just for show it in the console
foreach my $row (@pascaltriangle){
    foreach my $col (@$row){
        print $col; 
    }
    print "\n";
}
