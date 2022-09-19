#!raku

use Base::Any;

sub MAIN( Int:D $what ) {
    to-base(4,2i).say;
}
