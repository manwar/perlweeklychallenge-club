#!/usr/bin/env perl
# Perl weekly challenge 362
# Task 2:  Spellbound Sorting
#
# See https://wlmb.github.io/2026/02/23/PWC362/#task-2-spellbound-sorting
use v5.36;
use feature qw(try);
use List::UtilsBy qw(sort_by);
use Scalar::Util qw(looks_like_number);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to sort the numbers space separated list of numbers Nn
    alphabetically. The language may be specified as the first
    element in the list.
    Current languages are English (default), Spanish or French.
    FIN
for(@ARGV){
    try {
	my ($Lang, @in)=split " ", $_;
	unshift(@in,$Lang), $Lang="English" if looks_like_number($Lang); # default
	my $sorter=undef;
	$sorter=\&english if $Lang=~/^English$/i;
	$sorter=\&spanish if $Lang=~/^Spanish$/i;
	$sorter=\&french  if $Lang=~/^French$/i;
	die "Unknown language: $Lang" unless defined $sorter;
	my @out=$sorter->(@in);
	say "@in in $Lang -> @out";
    }
    catch($e){warn $e;}
}

sub english(@num){
    use Lingua::EN::Numbers qw(num2en);
    return map {$_->[0]} sort_by {$_->[1]} map{[$_, num2en($_)]}@num;
}
sub spanish(@num){
    use Lingua::ES::Numeros;
    my $trans = Lingua::ES::Numeros->new();
    return map {$_->[0]} sort_by {$_->[1]} map{[$_, $trans->cardinal($_)]}@num;
}
sub french(@num){
    use Lingua::FR::Numbers qw(number_to_fr);
    return map {$_->[0]} sort_by {$_->[1]} map{[$_, number_to_fr($_)]}@num;
}
