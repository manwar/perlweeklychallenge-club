#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    $line =~ y/a-j/0-9/;  # Turn letters into digits
    my ($n1, $n2, $sum) = split ' ' => $line;
    say $sum == $n1 + $n2 ? "true" : "false";
}

__END__
