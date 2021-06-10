#!raku

# a) You have 12 tokens
#    b) Each player can pick 1, 2 or 3 tokens at a time
#                                 c) The player who picks the last token wins the game


sub MAIN() {
    # all tokens are True-selectable
    my @tokens = True xx 12;

    my @players = <Player1 Player2>;

    while ( @tokens.elems > 0 ) {
        for @players -> $player {
            my $how-many = ( 1 .. min( 3, @tokens.elems ) ).pick;
            @tokens.pop for 1 .. $how-many;
            say "$player picks $how-many, remaining { @tokens.elems }";

            if @tokens.elems == 0 && $how-many > 0 {
                "Player $player won!".say && exit;
            }
        }

    }

}
