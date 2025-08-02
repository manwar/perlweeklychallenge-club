use v5.36;
use List::Util qw(product);

sub all_odd($str) {
    my %par;
    $par{$_} ^= 1 for split //, $str;
    product values %par
}

for my $t (@ARGV) {
    say "$t: ", all_odd($t) ? "true" : "false";
}
