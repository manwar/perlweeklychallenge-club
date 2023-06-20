use strict;
use warnings;

sub count_matching_members {
    my @original = @_;
    my @sorted   = sort { $a <=> $b } @original;

    my $count = 0;
    for my $i ( 0 .. $#original ) {
        if ( $original[$i] == $sorted[$i] ) {
            $count++;
        }
    }
    return $count;
}

print count_matching_members( 1, 1, 4, 2, 1, 3 ), "\n";
print count_matching_members( 5, 1, 2, 3, 4 ), "\n";
print count_matching_members( 1, 2, 3, 4, 5 ), "\n";
