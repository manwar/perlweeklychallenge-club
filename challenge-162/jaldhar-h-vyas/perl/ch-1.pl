#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub Zmultiply {
    my ($first, $second) = @_;
    my @result;

    for my $i (0 .. scalar @{$second} - 1) {
        push @result, $first->[$i] * $second->[$i];
    }

    return wantarray ? @result : \@result;
}

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <isbn>
  
    <isbn>    An ISBN in the format nnn-n-nnn-nnnnn-n
-USAGE-
    exit 0;
}

my $isbn = shift // usage();

if ( $isbn !~ /(\d{3}) \- (\d) \- (\d{3}) \- (\d{5}) \- (\d) /msx ) {
    usage();
}

my @digits = split //, (join q{}, @{^CAPTURE}); 
my @multipliers = (1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3);

my $checkdigit = 10 - sum([Zmultiply([@digits[0 .. 11]], \@multipliers)]) % 10;
say $checkdigit, ($checkdigit == $digits[12] ? ' (valid)' : ' (invalid)');
