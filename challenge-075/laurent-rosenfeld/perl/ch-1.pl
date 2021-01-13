use strict;
use warnings;
use feature "say";

my $target_sum = shift;
my $prev = 0;
my @coins = grep { $_ > $prev and $prev = $_}  sort { $a <=> $b } @ARGV;
die "Need at least two integer values" unless @coins;
my @result;
find_sum(0, ());
say for @result;

sub find_sum {
    my ($start, @allocated_so_far) = @_;
    return if $start > $target_sum;
    if ($start == $target_sum) {
        push @result, join " ", @allocated_so_far;
    } else {
        my $last_coin = $allocated_so_far[-1] // 0;
        for my $coin (grep $_ >= $last_coin, @coins) {
            find_sum($start + $coin, @allocated_so_far, $coin);
        }
    }
}
