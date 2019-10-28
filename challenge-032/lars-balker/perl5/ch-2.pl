use strict;
use warnings;
my $hashes = 24;

my $data = { apple => 3, cherry => 2, banana => 1 };
generate_bar_graph($data);
print "\n";
generate_bar_graph($data,1);

sub generate_bar_graph {
    my $data = shift;
    my $order_by_label = shift;

    my ($sum, $maxlength) = (0, 0);
    for my $word (keys %$data) {
        $maxlength = length($word) if length($word) > $maxlength;
        $sum += $data->{$word};
    }

    my $sort = $order_by_label
        ? sub { $a cmp $b }
        : sub { $data->{$b} <=> $data->{$a} || $a cmp $b };
    for my $word (sort $sort keys %$data) {
        my $pct = $data->{$word} / $sum;
        printf "%*s | %s\n", $maxlength, $word,
            "#" x int($hashes * $pct);
    }
}
