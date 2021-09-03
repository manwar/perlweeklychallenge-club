use strict;
use warnings;

my @Intervals = ( [3,4], [5,7], [6,9], [10, 12], [13,15] );

my @sets;
my $count = 0;

my @sort_arr;
my @conflicts;

foreach (@Intervals) {
    $count++;
    push @sets, $_;
    conflict($count, $_, @sets);
}

result(@conflicts);

sub conflict {
    my $count = shift;
    my $set   = shift;
    my @arr   = @_;

    my @sort_tmp;

   if (scalar(@arr) == 1) {
       print "- The $count interval ($set->[0],$set->[1]) do not have any previous intervals to compare with, so skip it.\n";
       return 0;
   }
    
    foreach (@arr) {
        if ($set->[0] > $_->[0] && $set->[0] < $_->[1]) {
            print "- The $count interval ($set->[0],$set->[1]) does conflict with some of the previous intervals.\n";
            push @conflicts, $set;
            return;
        }
    }
    print "- The $count interval ($set->[0],$set->[1]) do not conflicts with any of the previous intervals so skip it.\n";
}

sub result {
    my @conflicts = @_;
    print "[ ";
    foreach (@conflicts) {
        print "(" . $_->[0] . "," . $_->[1] . ") ";
    }
    print "]\n";
}