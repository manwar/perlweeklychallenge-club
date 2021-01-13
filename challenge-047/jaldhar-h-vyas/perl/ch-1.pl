#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
print STDERR <<"-END-";
Usage:
  $PROGRAM_NAME <num1> <op> <num2>
  
    <num1>    Number in Roman numerals
    <op>      Arithmetic operation (+ or -)
    <num2>    Number in Roman numerals
-END-
    exit(1);
}

sub unprefix {
    my ($num) = @_;

    my @from = qw/ CM    CD   XC    XL   IX    IV   /;
    my @to =   qw/ DCCCC CCCC LXXXX XXXX VIIII IIII /;

    for my $i (0 .. scalar @from - 1) {
        $num =~ s/$from[$i]/$to[$i]/g;
    }

    return $num;
}

sub reorder {
    my ($num) = @_;
    my %order = (
        'M' => 0, 'D' => 1, 'C' => 2, 'L' => 3, 'X' => 4, 'V' => 5, 'I' => 6
    );

    return join q{}, sort { $order{$a} <=> $order{$b} } split //, $num; 
}

sub normalize {
    my ($num) = @_;
    my @from = qw/ IIIII IIII VV VIV XXXXX XXXX LL LXL CCCCC CCCC DD DCD /;
    my @to =   qw/ V     IV   X  IX  L     XL   C  XC  D     CD   M  CM  /;

    for my $i (0 .. scalar @from - 1) {
        $num =~ s/$from[$i]/$to[$i]/g;
    }

    return $num;
}

sub substrings {
    my ($num) = @_;
    my %substrings;

    for my $i (0 .. (length $num)  - 1) {
        for my $j (1 .. (length $num) - $i) {
            my $ss = substr($num, $i, $j);
            $substrings{$ss}++;
        }
    }

    return sort { length $b <=> length $a } keys %substrings;
}

sub removeCommon {
    my ($num1, $num2) = @_;

    for my $ss (substrings($num1)) {
        if ($num1 =~ /$ss/ && $num2 =~ /$ss/) {
            $num1 =~ s/$ss//;
            $num2 =~ s/$ss//;
        }
    }

    return ($num1, $num2);
}

sub expandLargest {
    my ($num1, $num2) = @_;
    my %order = (
        'M' => 0, 'D' => 1, 'C' => 2, 'L' => 3, 'X' => 4, 'V' => 5, 'I' => 6
    );

    my @reverseOrder = qw/ M D C L X V I /;
    my %expansion = (
        'M' => 'DCCCCC', 'D' => 'CCCCC', 'C' => 'LXXXXX', 'L' => 'XXXXX',
        'X' => 'VIIIII', 'V' => 'IIIII', 'I' => q{}
    );

    my $first = substr($num2, 0, 1);
    if ($first) {
        my $i = ($first eq 'M') ? 0 : $order{$first} - 1;
        while ($i >= 0 && $num1 !~ /$reverseOrder[$i]/) {
            $i--;
        } 
        $num1 =~ s/$reverseOrder[$i]/$expansion{$reverseOrder[$i]}/;
    }

    return (reorder($num1), $num2);
}

if (scalar @ARGV != 3) {
    usage();
}

my ($num1, $op, $num2) = @ARGV;

if ($op eq '+') {

    say normalize(reorder(unprefix($num1) . unprefix($num2)));

} elsif ($op eq '-') {

    my $un1 = unprefix($num1);
    my $un2 = unprefix($num2);

    while (length $un2) {
        ($un1, $un2) = expandLargest(removeCommon($un1, $un2));
    }

    say normalize($un1);

} else {
    usage();
}
