#!/usr/bin/env perl
# Perl weekly challenge 095
# Task 2: Demo stack.
# Demonstrate Stack operations.
# See https://wlmb.github.io/2021/01/11/PWC95/#task-2-demo-stack
package Stack;
use List::Util;
use v5.12;
use Moo;
has _stack=>(is=>'ro', default=>sub{[]}, init_arg=>undef);
sub push {
    my $self=shift;
    my $x=shift;
    say "Push:\t$x";
    my $s=$self->_stack;
    push @$s, $x;
    $self->show;
}
sub pop {
    my $self=shift;
    my $s=$self->_stack;
    die "Empty stack" unless defined $s;
    my $top=pop @$s;
    say "Pop:\t$top";
    $self->show;
    return $top;
}
sub top {
    my $self=shift;
    my $top=$self->_stack->[-1];
    say "Top:\t$top";
    return $top;
}
sub exch {
    my $self=shift;
    my $x=$self->pop;
    my $y=$self->pop;
    say "Exch:\t$x <-> $y";
    $self->push($x);
    $self->push($y);
}
sub min {
    my $self=shift;
    my $s=$self->_stack;
    my $min=List::Util::min @$s;
    say "Min:\t$min";
    $self->push($min);
}
sub max {
    my $self=shift;
    my $s=$self->_stack;
    my $max=List::Util::max @$s;
    say "Max:\t$max";
    $self->push($max);
}
sub add {
    my $self=shift;
    my ($x, $y)=($self->pop,$self->pop);
    my $res=$x+$y;
    say "Add:\t$x + $y -> $res";
    $self->push($res);
}
sub sub {
    my $self=shift;
    my ($x, $y)=($self->pop,$self->pop);
    my $res=$y-$x;
    say "Sub:\t$y - $x -> $res";
    say "Sub:\t$res";
    $self->push($res);
}
sub mul {
    my $self=shift;
    my ($x, $y)=($self->pop,$self->pop);
    my $res=$x*$y;
    say "Mul:\t$x * $y -> $res";
    $self->push($res);
}
sub div {
    my $self=shift;
    my ($x, $y)=($self->pop,$self->pop);
    my $res=$y/$x;
    say "Div:\t$y / $x -> $res";
    $self->push($res);
}
sub cs {
    my $self=shift;
    my $x=$self->pop;
    my $res=-$x;
    say "CS:\t$x -> $res";
    $self->push($res);
}
sub inv {
    my $self=shift;
    my $x=$self->pop;
    my $res=1/$x;
    say "Inv:\t1/$x -> $res";
    $self->push($res);
}
sub show {
    my $self=shift;
    my $s=$self->_stack;
    say "Stack:\t", join " ", reverse @$s;
}

package main;
use Scalar::Util qw(looks_like_number);
my $s=Stack->new;
while(<>){
    chomp;
    $s->push($_), next if looks_like_number($_);
    $s->pop, next if lc $_ eq "pop";
    $s->top, next if lc $_ eq "top";
    $s->exch, next if lc $_ eq "exch";
    $s->min, next if lc $_ eq "min";
    $s->max, next if lc $_ eq "max";
    $s->add, next if $_ eq "+";
    $s->sub, next if lc $_ eq "-";
    $s->mul, next if lc $_ eq "*";
    $s->div, next if lc $_ eq "/";
    $s->cs, next if lc $_ eq "cs"; # change sign
    $s->inv, next if lc $_ eq "inv"; # invert
    $s->show, next if lc $_ eq "show";
    die "Unrecognized op";
}
