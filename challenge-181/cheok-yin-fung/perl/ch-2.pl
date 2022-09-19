# The Weekly Challenge 181
# Task 2 Hot Day
# Usage: ch-2.pl < temperature.txt
use v5.30.0;
use warnings;
use Date::Simple qw/:all/;

my $base_d = date('1900-01-01');

my %dt;
my @ans;

while (<>) {
    chomp;
    $_ =~ /(\d\d\d\d-\d\d-\d\d)\W+([.\d]+)/;
    $dt{date($1)-$base_d} = $2;
}

for (sort {$a<=>$b} keys %dt) {
    push @ans, $base_d+$_ if defined($dt{$_-1}) && $dt{$_-1} < $dt{$_};
}

say join "\n", @ans;

