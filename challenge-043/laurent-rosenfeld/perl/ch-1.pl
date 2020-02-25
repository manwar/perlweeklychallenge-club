use strict;
use warnings;
use feature qw /say/;
use constant TARGET => 11;

my %nums = map { $_ => 1 } qw/1 2 3 4 6/;
my %rings = (
    blue   => 8,
    yellow => 7,
    green  => 5,
    red    => 9,
    black  => 0
);

my @ring_sequences = ( [qw <red green>], [qw <blue yellow>] );
my @black_vals;

for my $seq_ref (@ring_sequences) {
    my $diff = 0;
    for my $ring (@$seq_ref) {
        $rings{$ring} += $diff;
        say "Added $diff to $ring ring, " if $diff;
        $diff = TARGET - $rings{$ring};
        die "No way" unless exists $nums{$diff};
        say "Added $diff to $ring ring";
        $rings{$ring} += $diff;
    }
    $rings{black} += $diff;
    push @black_vals, $diff;
}
my $black_diff = TARGET - $rings{black};
die "No way" unless exists $nums{$black_diff};
push @black_vals, $black_diff;
$rings{black} += $black_diff;
say "Added @black_vals to black ring";
say "\nFinal ring values:";
say "$_\t$rings{$_}" for keys %rings;
