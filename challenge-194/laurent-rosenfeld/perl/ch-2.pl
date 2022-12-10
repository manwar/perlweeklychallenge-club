use strict;
use warnings;
use feature qw/say/;

sub remove_one {
    my %histo;
    $histo{$_}++ for split //, shift;
    my @frequencies = sort { $b <=> $a } values %histo;
    my $largest = shift @frequencies;
    for my $count (@frequencies) {
        return 0 if $largest - 1 != $count;
    }
    return 1;
}
for my $test (<abbc xyzyyxz xzxz>) {
    printf "%-10s => %d\n", $test, remove_one($test);
}
