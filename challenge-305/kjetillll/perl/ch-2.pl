sub alien_sort {
    my @arr = @{ shift() };
    my $swap = join'', @{ shift() };
    eval "map y/$swap/a-z/r, sort map y/a-z/$swap/r, \@arr"
}

use Test::More tests => 2;
is_deeply [ alien_sort(@$_{qw(input alien)}) ], $$_{output} for
{ input => [ "perl", "python", "raku" ],
  alien => [ qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/ ],
  output => [ "raku", "python", "perl"] },
{ input => [ "the", "weekly", "challenge" ],
  alien => [ qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/ ],
  output => [ "challenge", "the", "weekly" ] }
