use strict;
use warnings;

sub name_game_lyrics {
    my $name         = shift;
    my $rest_of_name = substr $name, 1;
    return join(
        "\n",
        "    $name, $name, bo-b$rest_of_name,",
        "    Bonana-fanna fo-f$rest_of_name",
        "    Fee fi mo-m$rest_of_name",
        "    $name!",
    );
}

use Test::More;

is(
    name_game_lyrics('Katie'),
    join(
        "\n",
        '    Katie, Katie, bo-batie,',
        '    Bonana-fanna fo-fatie',
        '    Fee fi mo-matie',
        '    Katie!',
    ),
    'Example',
);

done_testing;
