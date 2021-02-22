#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <binary string> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::MoreUtils qw(each_arrayref part);

sub toflip($tgt,$strs) {
    my $sum=0;
    for (@{$strs}) {
	$sum += length (($tgt ^ $_) =~ s/\0//gr)
    }
    return $sum;
}

sub mostfreqchar($str) {
    my %freqs;
    my $chr;
    for (split //, $str) {	
	$freqs{$_}++;
	((! $chr) || ($freqs{$chr} < $freqs{$_})) && do {$chr=$_};
    }
    return $chr;
}

my ($bin,$nr) = @ARGV;
my @bins = unpack("(A$nr)*",$bin);

my $i=0;
my @crossbins = map {join '', @{$_}} (part { $i++ % $nr } (split //, $bin));

my $tgt = join "", (map {mostfreqchar $_} @crossbins);

say qq|Initial strings:\n${\ do {join "\n", @bins}}\n|;
say qq|Target string: $tgt\n|;
say qq|Have to flip: ${\ do {toflip($tgt,\@bins)}}|;
