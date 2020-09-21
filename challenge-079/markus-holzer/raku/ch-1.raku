unit sub MAIN( Int $N );

# This is not only the simplest, but also a quite fast solution
# It only loses (sometimes) to the kernighan algorithm
# See bench.raku in this directory

say ($N...1).map( + *.base(2).indices(1) ).sum % 1000000007