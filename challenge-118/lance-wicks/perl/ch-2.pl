use strict;
use warnings;

use lib './lib';
use Knight;

$|=1;

my $treasures
    = [ [ 0, 1 ], [ 1, 0 ], [ 1, 1 ], [ 2, 1 ], [ 3, 2 ], [ 5, 4 ] ];

my $least = 9999;
my $path;

for ( 1 .. 99999 ) {
    my $k   = Knight->new( treasures => $treasures );
    my $res = $k->go;
    if ( $res->{moves} < $least ) {
        $least = $res->{moves};
		$path  = $res->{path};
		print "$least\n";
    }
}

print "\n\nPath: ";
for (@$path) {
    print  "($_->[0],$_->[1]) ";
}
print "\nLeast moves: $least\n";
