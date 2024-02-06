sub odd_char {
    my %toggle;
    $toggle{$_}++ and delete $toggle{$_} for "@_ "=~/./gs;
    (keys%toggle)[0];
}

use Test::More;
is( odd_char("Perl", "Preel")     => 'e' );
is( odd_char("Weekly", "Weeakly") => 'a' );
is( odd_char("Box", "Boxy")       => 'y' );
done_testing;
