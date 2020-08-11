use warnings;
use strict;

my $csv = @ARGV && $ARGV[0] eq '-csv';
shift if $csv;

my %words;
my $maxlength = 0;
while (<>) {
    chomp;
    ++$words{$_};
    $maxlength = length if length > $maxlength;
}

for my $word (sort { $words{$b} <=> $words{$a} || $a cmp $b } keys %words) {
    if ($csv) {
        printf "%s,%d\n", $word, $words{$word};
    }
    else {
        printf "%-*s %4d\n", $maxlength, $word, $words{$word};
    }
}
