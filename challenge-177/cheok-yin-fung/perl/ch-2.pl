# The Weekly Challenge 177
# Task 2 Palindromic Prime

use v5.30.0;
use warnings;

sub is_prime {
    my $n = $_[0];
    my $k = 1;
    while ($n % (6*$k-1) && $n % (6*$k+1) && (6*$k+1 <= sqrt $n)) {
        $k++;
    }
    return $n % (6*$k-1) && $n % (6*$k+1);
}

my @arr;
my $pali = 1;
while (scalar @arr < 20) {
    if ( (scalar reverse $pali) % 2 && $pali % 3 && $pali !~ /0/ ) {
        my $n = $pali."0".(scalar reverse $pali);
        if (is_prime($n)) {
            say $n;
            push @arr, $n;
        }
    }
    $pali++;
}
