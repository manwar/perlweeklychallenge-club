sub task1 { @^words».split($^seperator, :skip-empty).flat }


my @tests =
    ( '.' , <one.two.three four.five six> , <one two three four five six> ),
    ( '$' , <$perl$$ $$raku$>             , <perl raku> ),
;
use Test; plan +@tests;
for @tests ->      ( $in_sep, @in_strings,   @expected ) {
    is-deeply task1( $in_sep, @in_strings ), @expected;
}
