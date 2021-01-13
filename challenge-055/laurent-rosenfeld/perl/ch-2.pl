use strict;
use warnings;
use feature "say";

my %results;

sub add_1_item {
    my ($mode, $input, $output) = @_;
    unless (@$input) {
        $results{"@$output"} = 1;
        return;
    }
    my $last = $output->[-1];
    for my $i (0..$#$input) {
        if ($mode == 0) {
            next if $input->[$i] > $last;
            add_1_item(1, [@$input[0..$i-1, $i+1..$#$input]],
                [@$output, $input->[$i]]);

        } else {
            next if $input->[$i] < $last;
            add_1_item(0, [@$input[0..$i-1, $i+1..$#$input]],
                [@$output, $input->[$i]]);
        }
    }
}
my @in = (1, 2, 3, 4);
@in = @ARGV if defined $ARGV[0];
for my $i (0..$#in) {
    add_1_item(0, [@in[0..$i-1, $i+1..$#in]], [$in[$i]]);
}
say for sort keys %results;
