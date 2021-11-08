#!/usr/bin/env perl
# Perl weekly challenge 115
# Task 1: String Chain. Build the circle.
#
# See https://wlmb.github.io/2021/06/01/PWC115/#task-1-string-chain
use strict;
use warnings;
use v5.12;
use List::Util qw(first any);

my @strings=@ARGV;
die "Usage ./ch-1.pl string1 [string2...]" unless @strings;
my %followers;
map {my $f=$_;
     $followers{$f}=[];
     map {push @{$followers{$f}}, $_ if follows($f, $_)}@strings
     } @strings;
my @paths=([$strings[0]]);
foreach (1..@strings-1){
    @paths=grow(@paths);
}
say "Input: ", join " ", @strings;
my $path=first {follows($_->[-1], $_->[0])} @paths;
say "Output: ", defined $path?1:0;
say "Path: ", join "-", @$path if defined $path;

sub follows {
    my ($from, $to)=@_;
    return substr($from,-1,1) eq substr($to,0,1);
}

sub grow {
    my @paths=@_;
    my @new;
    push @new, grow_one($_) for @paths;
    return @new;
}

sub grow_one {
    my $path=shift;
    my @new=grep {defined $_} map {add_to($path, $_)} @{$followers{$path->[-1]}};
    return @new;
}

sub add_to {
    my ($path, $string)=@_;
    return if any {$_ eq $string} @$path; # don't add duplicates
    my @new=@$path; #copy
    push @new, $string;
    return [@new];
}
