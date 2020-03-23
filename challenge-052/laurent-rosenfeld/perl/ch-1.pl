use strict;
use warnings;
use feature "say";

die "Please provide two numbers between 100 and 999" if @ARGV != 2;
my ($start, $end) = @ARGV;
chomp $end;
die "Invalid parameters" if $start !~ /^\d{3}$/ or $end !~ /^\d{3}$/;
($start, $end) = ($end, $start) if $start > $end;
for my $num ($start..$end) {
    my @digits = split //, $num;
    if (abs($digits[0] - $digits[1]) == 1 &&
        abs($digits[1] - $digits[2]) == 1) {
        say "$num is a stepping number.";
    }
}
