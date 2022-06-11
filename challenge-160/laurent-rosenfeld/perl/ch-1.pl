use strict;
use warnings;
use feature "say";

sub is_magic {
    my $n = shift;
    my @numbers = qw<zero one two three four five six seven eight nine>;
    my $output = "";
    while (1) {
        my $letter_count = length $numbers[$n];
        if ($n == 4) {
            return $output . "four is magic.";
        } else {
            $output .= "$numbers[$n] is $numbers[$letter_count], ";
            $n = $letter_count;
        }
    }
}
for my $m (1..9) {
  say "$m: ", ucfirst(is_magic($m));
}
