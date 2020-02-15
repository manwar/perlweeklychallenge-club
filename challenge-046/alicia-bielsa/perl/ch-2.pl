#Is the room open?
#There are 500 rooms in a hotel with 500 employees having keys to all the rooms. 
#The first employee opened main entrance door of all the rooms. The second employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500. The third employee then closed the door if it was opened or opened the door if it was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the fourth employee did the same as the third but only room numbers 4,8,12,16 and so on to 500. This goes on until all employees has had a turn.
#
#Write a script to find out all the rooms still open at the end.

use strict;
use warnings;

my $TOTAL = 500;
my @aRooms =  (0) x $TOTAL;	
foreach my $employee (1..$TOTAL){
    foreach my $door ($employee..$TOTAL){ 
        if ($door % $employee == 0 ){            
            $aRooms[$door-1] = flipStatus ($aRooms[$door-1]);
        }
    }
}

foreach my $room (0..$#aRooms){
    if ($aRooms[$room]){
        $room ++;
        print "Room $room opened\n";    
    }
}
sub flipStatus {
    my $status = shift;
    if ($status){
        return 0;
    } 
    return 1;
}