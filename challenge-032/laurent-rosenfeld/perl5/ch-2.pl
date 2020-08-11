use strict;
use warnings;
use feature qw/say/;

sub generate_chart {
    my %data = %{$_[0]};
    my $sort_type = $_[1] // "val";
    my ($max, $min);
    for my $key (keys %data) {
        ($max, $min) = ($data{$key}, $data{$key}) unless defined $max;
        $max = $data{$key} if $data{$key} > $max;
        $min = $data{$key} if $data{$key} < $min;
    }
    my $scale_factor = 10 / ($max - $min);
    my $sort_routine = ($sort_type =~ /val/i)
        ? sub { $data{$b} <=> $data{$a} }
        : sub {$a cmp $b };
    for my $key (sort $sort_routine keys %data) {
        printf "%15s | %s\n", $key, "#" x ($data{$key} * $scale_factor);
    }
}
my $sort_type = shift;
my $data = { cherry => 20, apple => 30,  banana => 10, pear => 25};
generate_chart $data, $sort_type;
