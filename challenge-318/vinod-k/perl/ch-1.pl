use strict;
use warnings;

use constant LIMIT => 2;
my $str = "aaabcddddeeff";

my @array = split(//, $str);
my $size = scalar @array;

my $group = $array[0];

for (my $i = 1; $i < $size; $i++) {
    if ($array[$i] eq $array[$i - 1]) {
        $group .= $array[$i];
    } else {
        print "$group\n" if length($group) > LIMIT;
        $group = $array[$i];
    }
}

print "$group\n" if length($group) > LIMIT;
