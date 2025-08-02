use strict;

my @ints = @ARGV;
my $verbose = $ENV{PERL_SCRIPT_VERBOSE} || 0;

if ($#ints < 0) {
    print "Please specify at least 1 number as argument!\n";
    exit 1
}

my $minimum_start_value = 1;

my $smallest_sum = find_smallest_sum($minimum_start_value);
if ($smallest_sum < 1) {
    $minimum_start_value = ($minimum_start_value + 1 - $smallest_sum);
    find_smallest_sum($minimum_start_value) == 1 or die "Could not find minimum positive start value for numbers (" . join(", ", @ints) . ")";
}

print "$minimum_start_value\n";

sub find_smallest_sum($) {
    my $smallest_sum = undef;
    my $left_summand = shift;

    foreach my $right_summand (@ints) {
        my $sum = $left_summand + $right_summand;
        print "> $left_summand + $right_summand = $sum\n" if $verbose;
        $smallest_sum = $sum if (! defined $smallest_sum || $sum < $smallest_sum);
        $left_summand = $sum;
    }
    print "Smallest sum: $smallest_sum\n\n" if $verbose;

    return $smallest_sum;
}


