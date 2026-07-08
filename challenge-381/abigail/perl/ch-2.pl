#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my @numbers = split ' ' => $line;
    my ($min_c, $max_c, $min, $max) = (0, 0);
    for my $number (@numbers) {
       ($min_c, $min) = (0, $number) if !$min_c || $number <  $min;
       ($max_c, $max) = (0, $number) if !$max_c || $number >  $max;
        $min_c ++                    if            $number == $min;
        $max_c ++                    if            $number == $max;
    }
    say @numbers - $min_c - ($min == $max ? 0 : $max_c);
}

__END__
