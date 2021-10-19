#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <m> <n>
-USAGE-
    exit 0;
}

if (scalar @ARGV != 2) {
    usage;
}

my ($m, $n) = @ARGV;

my $mlength = length $m;
my $nlength = length $n;
my $mnlength = length ($m * $n);
my %terms;

say q{}, (sprintf "% ${\($mlength + 2)}s", 'x |'),
    map { sprintf "% ${\($mnlength)}s ", $_} 1 .. $n;
say q{-} x ($mlength + 1), q{+}, q{-} x ($n * ($mnlength + 1) - 1);

for my $em (1 .. $m) {
    printf "% ${\($mlength)}s |", $em;
    for my $en (1 .. $n) {
        my $term = $em * $en;
        $terms{$term}++;
        printf "% ${\($mnlength)}s ", $term;
    }
    print "\n";
}
print("\n");

say 'Distinct Terms: ', join q{, }, sort { $a <=> $b } keys %terms;
say 'Count: ', scalar keys %terms;
