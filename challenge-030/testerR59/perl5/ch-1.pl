use strict;
use warnings;

use Time::Local qw(timelocal_modern);

for(2019..2100){
    my $wday = (localtime timelocal_modern 0, 0, 0, 25, 11, $_)[6];
    print "25 Dec $_\n" if $wday == 0
}
