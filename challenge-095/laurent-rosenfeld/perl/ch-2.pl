#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub is_empty {
    my $stack = shift;
    return @$stack > 0 ? 0 : 1;
}

sub put_in_stack {
    my ($stack, @new_items) = @_;
    push @$stack, @new_items;
}
sub take_from_stack  {
    my $stack = shift;
    return undef if is_empty $stack;
    return pop @$stack;
}
sub top {
    my $stack = shift;
    return undef if is_empty $stack;
    return $stack->[-1];
}
sub minimum {  # assuming stack of numeric values
    my $stack = shift;
    return undef if is_empty $stack;
    my $min = $stack->[0];
    for my $item (@$stack) {
        $min = $item if $item < $min;
    }
    return $min;
}
my $a_stack = [1..5];
say "@$a_stack";
put_in_stack $a_stack, 6..8;
say "@$a_stack";
say "Min: ", minimum $a_stack;
say "Top: ", top $a_stack;
say "Take: ", take_from_stack $a_stack;
say "@$a_stack";
