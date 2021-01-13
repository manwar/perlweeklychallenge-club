use strict;
use warnings;
use feature "say";
use constant INF => 10 ** 12;
use Data::Dumper;

my @a = (defined $ARGV[0]) ? @ARGV : (3, 8, 10);
my %result;
my @used;
sum_up (\@a, \@used);

sub sum_up {
    my @in =  @{$_[0]};
    my @used_so_far =  @{$_[1]};
    if (@in <= 0) {
        my $sum = 0;
        $sum += $_ for @used_so_far;
        push @{$result{$sum}}, [@used_so_far] if $sum >= 0;
    } else {
        my $item = shift @in;
        sum_up(\@in, [@used_so_far, $item]);
        sum_up(\@in, [@used_so_far, - $item]);
    }
}
# say "Result: \n", Dumper \%result;
my $min_sum = (keys %result)[0];
for my $key (keys %result) {
    $min_sum = $key if $key < $min_sum;
}
if (scalar @{$result{$min_sum}} <= 1) {
    say "Sum: $min_sum - digits: @{$result{$min_sum}[0]}";
    say "Number of negative numbers: ",
        scalar grep $_ < 0, @{$result{$min_sum}[0]};
} else {
    my $min_neg = INF;
    my $min_neg_index;
    my @candidates = @{$result{$min_sum}};
    for my $i (0..$#candidates) {
        my $negative_numbers = scalar grep $_ < 0, @{$candidates[$i]};
        if ($negative_numbers < $min_neg) {
            $min_neg = $negative_numbers;
            $min_neg_index = $i;
        }
    }
    say "Sum: $min_sum - digits:    @{$candidates[$min_neg_index]}";
    say "Number of negative numbers: $min_neg";
}
