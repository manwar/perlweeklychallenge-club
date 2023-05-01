use strict;
use warnings;

sub can_replace_zeroes {
    my ( $numbers_ref, $count ) = @_;
    my @numbers = @$numbers_ref;

    return 1 if $count == 0;

    my @groups;
    my $consecutive_zeroes = 0;

    foreach my $num (@numbers) {
        if ( $num == 0 ) {
            $consecutive_zeroes++;
        }
        else {
            if ( $consecutive_zeroes > 0 ) {
                push @groups, $consecutive_zeroes;
                $consecutive_zeroes = 0;
            }
        }
    }

    if ( $consecutive_zeroes > 0 ) {
        push @groups, $consecutive_zeroes;
    }

    if ( scalar @groups == 1 && $groups[0] == scalar @numbers ) {
        return 1 if ( $groups[0] + 1 ) / 2 >= $count;
        return 0;
    }

    my $replaceable_zeroes = 0;
    for my $i ( 0 .. $#groups ) {
        if ( $i == 0 || $i == $#groups ) {
            $replaceable_zeroes += int( $groups[$i] / 2 );
        }
        else {
            $replaceable_zeroes += int( ( $groups[$i] - 1 ) / 2 );
        }
    }

    return 1 if $replaceable_zeroes >= $count;
    return 0;
}

# Test cases
my @numbers1 = ( 1, 0, 0, 0, 1 );
my $count1   = 1;
my @numbers2 = ( 1, 0, 0, 0, 1 );
my $count2   = 2;
my @numbers3 = ( 1, 0, 0, 0, 0, 0, 0, 0, 1 );
my $count3   = 3;

print can_replace_zeroes( \@numbers1, $count1 ), "\n";    # Output: 1
print can_replace_zeroes( \@numbers2, $count2 ), "\n";    # Output: 0
print can_replace_zeroes( \@numbers3, $count3 ), "\n";    # Output: 1
