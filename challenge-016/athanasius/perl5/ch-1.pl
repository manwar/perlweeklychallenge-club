use strict;
use warnings;
use Const::Fast;
use constant DEBUG => 0;

const my $GUESTS => 100;

MAIN:
{
    my $pie       = 1;
    my $max_guest = 1;
    my $max_piece = 1 / $GUESTS;
    my $sum       = $max_piece if DEBUG;
       $pie      -= $max_piece;

    printf("\nGuest %*d gets %43.40f%% of the original pie\n",
            length $GUESTS, $max_guest, $max_piece * 100) if DEBUG;

    for my $guest (2 .. $GUESTS)
    {
        my $piece = ($guest / $GUESTS) * $pie;
           $pie  -=  $piece;

        if (DEBUG)
        {
            printf "Guest %*d gets %43.40f%% of the original pie\n",
                    length $GUESTS, $guest, $piece * 100;
            $sum += $piece;
        }

        if ($piece > $max_piece)
        {
            $max_piece = $piece;
            $max_guest = $guest;
        }
    }

    printf "\nGuest %d of %d gets the largest piece, which is " .
             "%.2f%% of the original pie\n", $max_guest, $GUESTS,
              $max_piece * 100;

    printf("\nCheck: sum of pieces = %.13f%%\n", $sum * 100)
        if DEBUG;
}
