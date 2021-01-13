#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>
  
    <N>    number to check
-USAGE-
    exit(1);
}

sub isPower {
    my ($num) = @_;
    my @results;

    if ($num == 1) {
        push @results, join q{^}, (1, 1); 
    } else {
        for my $m (2 .. sqrt($num)) {
            my $n = 2; 
            my $p = $m ** $n; 
  
            while ($p <= $num && $p > 0) { 
                if ($p == $num) { 
                    push @results, join q{^}, ($m, $n);
                } 
                $n++; 
                $p = $m ** $n; 
            } 
        }
    } 

    return @results; 
}

if (scalar @ARGV < 1) {
    usage();
}
my ($N) = @ARGV;

my @powers = isPower($N);
say scalar @powers ? (join q{, }, @powers) : 0;
