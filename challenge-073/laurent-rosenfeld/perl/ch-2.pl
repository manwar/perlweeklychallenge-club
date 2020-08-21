use strict;
use warnings;
use feature qw/say/;

my @a = (7, 8, 3, 12, 10);
my @result = (0);
my $min = shift @a;
for my $item (@a) {
    if ($item < $min) {
        push @result, 0;
        $min = $item;
    } else {
        push @result, $min;
    }
}
say "@result";
