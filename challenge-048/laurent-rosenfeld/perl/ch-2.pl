use strict;
use warnings;
use feature "say";

for my $year (2000 .. 2300) {
    my ($month, $day) = (reverse $year) =~ /(\d\d)(\d\d)/;
    next if $month > 12 or $month < 1 or $day > 31 or $day < 1;
    say "$month/$day/$year is a palindromic date.";
}
