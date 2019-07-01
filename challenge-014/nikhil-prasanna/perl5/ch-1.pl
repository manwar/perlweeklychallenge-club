use strict;
use warnings;
use Data::Dumper;
#initialising sequence
my @arr = (0);
my %sequenceMap =
    (0 => {
        'last' => 0,
    },
    ) ;
print $sequenceMap{0}{'last'};

sub vanEck {
    my $n = shift;
    return  if $n == 1;

    for my $i (1..$n) {
        my $lastNumber = $arr[$#arr];
        my $nextNumber;
        if ( exists( $sequenceMap{$lastNumber}{'second_last'} )) {
            $nextNumber = $sequenceMap{$lastNumber}{'last'} - $sequenceMap{$lastNumber}{'second_last'};


        } else {
            $nextNumber = 0;
        }
        push(@arr, $nextNumber );


        if ( exists($sequenceMap{$nextNumber})) {
            $sequenceMap{$nextNumber}{'second_last'} = $sequenceMap{$nextNumber}{'last'};
            $sequenceMap{$nextNumber}{'last'} = $#arr;
        } else {
            $sequenceMap{$nextNumber}={'last' => $#arr};
        }
    }

}

print "Enter a number upto which you want to find the Van Eck sequence \n";
my $n = <STDIN>;

vanEck($n);
print Dumper(\@arr)."\n";
print Dumper(\%sequenceMap);
