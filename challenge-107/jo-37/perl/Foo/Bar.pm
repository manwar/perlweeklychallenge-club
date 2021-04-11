package Foo::Bar;

sub foo_bar {}
our @array;
our %hash;
INIT {
    our $scalar = 1;
    *FH = *STDIN{IO};
}
() = *FH;
format FORMAT =
. 

1;
