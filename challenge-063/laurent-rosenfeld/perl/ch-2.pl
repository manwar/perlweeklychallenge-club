use strict;
use warnings;
use feature 'say';

sub rotate_once {
    my ($str, $num) = @_;
    substr($str, $num, length($str) - $num) . substr($str, 0, $num);
}
sub rotate_str {
    my $origin_str = shift;
    my $tmp = $origin_str;
    my $len = length $origin_str;
    my $i = 1;
    while (1) {
        $tmp = rotate_once $tmp, $i % $len;
        return $i if $tmp eq $origin_str;
        $i++;
    }
}
for (qw<xyxx xxyyy abcdefgh>) {
    say "Got original string $_ after ", rotate_str($_), " rotations.";
}
