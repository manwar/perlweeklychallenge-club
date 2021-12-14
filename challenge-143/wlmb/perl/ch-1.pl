#!/usr/bin/env perl
# Perl weekly challenge 143
# Task 1: calculator
#
# See https://wlmb.github.io/2021/12/13/PWC143/#task-1-calculator
use v5.12;
use warnings;
use Scalar::Util qw(looks_like_number);
my $original_string;
my $current;
my $next;
foreach (@ARGV){
    my $original_string=$current=$_;
    token();
    my $result=expression();
    say "$original_string=$result";
}

sub token {
    $next=[$1,$1], return if $current=~s{^\s*([()*/+-])}{}; # symbol
    $next=['N',$1], return
        if $current=~s{^\s*([^()*/+\-\t\n ]*)}{}
           and looks_like_number($1); # number?
    $next=[undef,undef], return if $current=~/^\s*$/; # nothing
    die "Unrecognizable input: $current";
}

sub expression {
    my $result=term();
    while(1){
	my $op=$next->[0];
	last unless defined $op && $op=~m{[+-]};
	token();
	$result+=term(),next if $op eq '+';
	$result-=term(),next if $op eq '-';
    }
    return $result;
}

sub term {
    my $result=simple();
    while(1){
	my $op=$next->[0];
	last unless defined $op && $op=~m{[*/]};
	token();
	$result*=simple(),next if $op eq '*';
	$result/=simple(),next if $op eq '/';
    }
    return $result;
}
sub simple {
    my $op=$next->[0];
    my $val=$next->[1];
    die "Unrecognized expression: $current" unless defined $op && $op=~/[-(N]/;
    token();
    return -simple() if $op eq '-';
    return $val if $op eq 'N';
    my $result=expression();
    $op=$next->[0];
    die "Unbalanced parenthesis: $current" unless defined $op and $op eq ')';
    token();
    return $result;
}
