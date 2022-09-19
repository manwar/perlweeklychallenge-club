use strict;
use warnings;
use feature qw/say/;

my @daily_temps;
my $file_in = "./temperature.txt";
open my $IN, "<", $file_in or die "Cannot open $file_in $!";
while (my $line = <$IN>) {
    chomp $line;
    push @daily_temps, [ split /,\s/, $line ];
}
my $temp = 1e9;
for my $record (sort {$a->[0] cmp $b->[0]} @daily_temps) {
    say $record->[0] if $record->[1] > $temp;
    $temp = $record->[1];
}
