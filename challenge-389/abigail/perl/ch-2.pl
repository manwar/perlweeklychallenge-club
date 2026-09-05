#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my ($max, @nums) = (1, split /\s+/ => $line);
    my $str = join "" => map {1 + ($nums [$_ - 1] <=> $nums [$_])} 1 .. $#nums;
    $_ > $max && ($max = $_) for map {1 + length} $str =~ /0?(?:20)*2?/g;
    say $max
}

__END__
