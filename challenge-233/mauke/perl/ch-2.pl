use v5.36;

my @ints = @ARGV;

my %seen;
$seen{$_}++ for @ints;

say for sort {
    $seen{$a} <=> $seen{$b} ||
    $b <=> $a
} @ints;
