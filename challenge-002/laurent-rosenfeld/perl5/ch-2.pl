use strict;
use warnings;
use feature "say";
use constant lookup => ('0'..'9','A'..'Z');

sub convert_base {
    my ($num, $base) = @_;
    my $result = "";
    do {
        $result .= (lookup)[$num % $base];
        $num = int ($num/$base);
    } while $num > 0;
    $result = reverse $result;
}
for my $number (0..45, qw/1757 533 658467/) {
    say "$number\t:\t", convert_base $number, 35;
}
