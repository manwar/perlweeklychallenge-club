#!raku

sub MAIN() {
    my @triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ];
#    @triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ];
    my $sum += .min for @triangle;
    say $sum;
}
