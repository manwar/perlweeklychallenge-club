use v6;

my UInt constant $GUESTS = 100;

sub MAIN()
{
    my Real $pie       = 1;
    my UInt $max-guest = 1;
    my Real $max-piece = 1 / $GUESTS;
            $pie      -= $max-piece;

    for 2 .. $GUESTS -> UInt $guest
    {
        my Real $piece = ($guest / $GUESTS) * $pie;
                $pie  -=  $piece;

        if ($piece > $max-piece)
        {
            $max-piece = $piece;
            $max-guest = $guest;
        }
    }

    my Real $max-piece-pc = $max-piece * 100;

    say "\nGuest $max-guest of $GUESTS gets the largest piece, ",
          "which is $max-piece-pc.round(0.01)% of the original pie";
}
