#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my @letters = map {ord} split;
    my ($qi)   = grep {$letters [$_] == ord "?"} keys @letters;
    my $base = $letters [$qi <= 2 ? $qi + 1 :                      $qi - 1];
    my $from = $letters [$qi <  2 ? $qi + 3 : $qi == 2 ? $qi - 1 : $qi - 3];
    my $to   = $letters [$qi <  2 ? $qi + 2 :                      $qi - 2];
    say chr $base - $from + $to;
}

__END__
