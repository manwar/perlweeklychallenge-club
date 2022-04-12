use strict;
use warnings;
use feature "say";

sub farey {
    my $n = shift;
    my (@out, %seen);
    for my $den (1..$n) {
        for my $num (0..$den) {
            next if exists $seen{$num/$den};
            push @out, [$num, $den];
            $seen{$num/$den} = 1;
        }
    }
    return @out;
}
for my $test (3..7) {
    my @result = sort { $a->[0]/$a->[1] <=> $b->[0]/$b->[1] } farey($test);
    print "$test: ";
    print "$_->[0]/$_->[1] " for @result;
    say "";

}
