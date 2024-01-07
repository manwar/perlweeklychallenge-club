# The Weekly Challenge 250
# Task 2 Alphanumeric String Value
use v5.30.0;
use warnings;
use List::Util qw/max/;

sub asv {
    my $word = $_[0];
    return $1 if $word =~ /^0*(\d+)$/;
    return length $word;
}

sub masv {
    my @arr = @_;
    return max map {asv $_} @arr; 
}


use Test2::V0;
ok masv("perl", "2", "000", "python", "r4ku") == 6;
ok masv("001", "1", "000", "0001") == 1;
done_testing();
