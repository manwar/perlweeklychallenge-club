use strict;
use warnings;

# You are asked to sell juice each costs $5. You are given an array of
# notes. You can only sell ONE juice to each customer but make sure you
# return exact change back. You only have $5, $10 and $20 notes. You do
# not have any change in hand at first.
#
# Write a script to find out if it is possible to sell to each customers
# with correct change.
#
# NOTE: At first blush it might seem like we have to recursively handle
#       $20 notes, as there may be two possible solutions, 10 + 5 or 5 +
#       5 + 5. HOWEVER, it turns out that the 10 + 5 solution is always
#       "correct" in this situation. With the current rules there are no
#       situations where "saving" the $10 for later would help us
#       complete a transaction, but there are situations where "saving"
#       the $5 notes would help us complete a transaction. If there were
#       other prices involved, or other denominations then the situation
#       would be different.

sub exact_change {
    my ($notes) = @_;
    my %wallet = ( 5 => 0, 10 => 0, 20 => 0 );

    foreach my $bill (@$notes) {
        die "Bad bill '$bill'" unless exists $wallet{$bill};
        if ( $bill == 20 ) {
            if ($wallet{10} and $wallet{5}) {
                $wallet{10}--;
                $wallet{5}--;
            }
            elsif ($wallet{5} >= 3) {
                $wallet{5} -= 3;
            }
            else {
                return 0;
            }
        }
        elsif ( $bill == 10 ) {
            $wallet{5}--
                or return 0;
        }
        $wallet{$bill}++;
    }
    return 1;
}

use Test::More;
foreach my $tuple (
    [1,[5,5,5,10,20]],
    [0,[5,5,10,10,20]],
    [1,[5,5,5,20]],
    [1,[5,5,5,5,10,20,10]],
) {
    my ($want, $notes)= @$tuple;
    my $got = exact_change($notes);
    is($got, $want, "exact_change(@$notes) == $want");
}
done_testing();
