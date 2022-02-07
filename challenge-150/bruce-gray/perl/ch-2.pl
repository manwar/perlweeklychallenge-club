use Modern::Perl;
use ntheory qw<is_square_free>;

say join ', ', grep { is_square_free($_) } 1 .. 500;
