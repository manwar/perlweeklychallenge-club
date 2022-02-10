#!/usr/bin/env perl
# Perl weekly challenge 148
# Task 2: largest square
#
# See https://wlmb.github.io/2022/01/24/PWC149/#task-2-largest-square
use v5.12;
use warnings;
use POSIX qw(floor);
use Algorithm::Combinatorics qw(combinations permutations);
use Try::Tiny;

die "Usage: ./ch-2a.pl N [P] [Q]... " .
    "to obtain largest square in base N P Q...\n"
    unless @ARGV;

my %map;
@map{(0..35)}=(0..9, 'A'..'Z');
my $largest=15;

try {say "f($_)=", largest_square($_)} catch {say $_} foreach(@ARGV);

sub largest_square {
    my $base=shift;
    die "Base $base is too large\n" if $base > $largest;
    my @digits=reverse 0..$base-1;
    my $result;
    for my $i(0..$base-1){ # $base-$i is the number of digits to try
        my $combinations=combinations(\@digits,$base-$i);
        while(my $c=$combinations->next){
            my $permutations=permutations($c);
            my $candidate;
            while(my $p=$permutations->next){
                # ignore numbers with leading zeroes
                # they would appear if when testing shorter candidates
                next unless $p->[0];
                my $number=digits_to_number($p, $base);
                my $sqrt=floor(sqrt($number));
                $candidate=$number, last if $number==$sqrt*$sqrt;
                # Found a candidate. The first is the largest so I don't
                # have to test further permutations
            }
            # But I may have to test different combinations
            $result=$candidate if defined $candidate and (!defined $result or $result<$candidate);
        }
        return number_to_digits_base($result, $base) if defined $result;
        # If I found a candidate for a given length, it is not necessary
        # to test shorter candidates
  }
}
sub digits_to_number {
    my ($digits, $base)=@_;
    my @digits=reverse @$digits;
    my $power=1;
    my $result=0;
    $result+=$_*$power, $power*=$base for(@digits);
    return $result;
}
sub number_to_digits_base {
    my ($result, $base)=@_;
    my @result=();
    do {push @result, $result%$base} while $result=floor $result/=$base;
    return map {$map{$_}} reverse @result;
}
