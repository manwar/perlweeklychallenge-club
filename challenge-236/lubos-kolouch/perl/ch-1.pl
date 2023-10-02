use strict;
use warnings;

sub can_sell_with_exact_change {
    my @bills = @_;
    my $five  = 0;
    my $ten   = 0;

    for my $bill (@bills) {
        if ( $bill == 5 ) {
            $five++;
        }
        elsif ( $bill == 10 ) {
            return 0 if $five == 0;
            $five--;
            $ten++;
        }
        else {
            if ( $ten > 0 && $five > 0 ) {
                $ten--;
                $five--;
            }
            elsif ( $five >= 3 ) {
                $five -= 3;
            }
            else {
                return 0;
            }
        }
    }

    return 1;
}

# Test Cases
print can_sell_with_exact_change( 5, 5, 5, 10, 20 )
  . "\n";    # Should return 1 (True)
print can_sell_with_exact_change( 5, 5, 10, 10, 20 )
  . "\n";    # Should return 0 (False)
print can_sell_with_exact_change( 5, 5, 5, 20 ) . "\n"; # Should return 1 (True)
