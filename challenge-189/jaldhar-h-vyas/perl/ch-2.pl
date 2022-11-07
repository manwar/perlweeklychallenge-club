#!/usr/bin/perl
use 5.030;
use warnings;
use English;


sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<array> ...]
  
    [<array> ...]    array of integers
-USAGE-
    exit(0);
}

if (scalar @ARGV < 2) {
    usage;
}

my @array = @ARGV;
my %degrees;

for my $n (@array) {
    $degrees{$n}++;
}

my $degree = $degrees{(sort { $degrees{$b} <=> $degrees{$a} } keys %degrees)[0] };

my @results;
for my $key (grep { $degrees{$_} == $degree } keys %degrees) {
    my $start = -1;
    my $end = -1;
    for my $i (0 .. scalar @array - 1) {
        if ($array[$i] == $key) {
            if ($start == -1) {
                $start = $i;
            } else {
                $end = $i;
            }
        }
    }
    push @results, [ @array[$start .. $end] ];
}

my @sorted = sort { @{$a} <=> @{$b} } @results;
say q{(} . (join q{, }, @{ shift @sorted }) . q{)};