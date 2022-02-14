#!raku

sub MAIN() {
    my @triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ];
    my $sum += $_.min for @triangle;
    $sum.say;
}
