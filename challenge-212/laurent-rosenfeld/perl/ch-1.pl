use strict;
use warnings;
use feature "say";

sub jump_letter  {
    my ($letter, $val) = @_;
    my $new_ascii = ord($letter) + $val;
    return chr($new_ascii - 26) if $new_ascii > ord 'z';
    return chr($new_ascii - 26) if $letter le 'Z'
        and $new_ascii > ord 'Z';
    return chr $new_ascii;
}

for my $test (["Perl", [<2 22 19 9>]], ["Raku", [<24 4 7 17>]]) {
    printf "%-10s => ", "$test->[0]";
    my @letters = split //, $test->[0];
    for my $i (0..$#letters) {
        print jump_letter $letters[$i], $test->[1][$i];
    }
    say " ";
}
