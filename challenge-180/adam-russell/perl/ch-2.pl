use v5.36;
use strict;
use warnings;
##
# You are given list of numbers, @n and an integer $i. Write a script to trim the given 
# list when an element is less than or equal to the given integer.
##
sub trimmer{
    my($i) = @_;
    return sub{
        my($x) = @_;
        return $x if $x > $i;
    }
}

sub trim_list_r{
    my($n, $trimmer, $trimmed) = @_;
    $trimmed = [] unless $trimmed;
    return @$trimmed if @$n == 0;
    my $x = pop @$n;
    $x = $trimmer->($x);
    unshift @$trimmed, $x if $x;
    trim_list_r($n, $trimmer, $trimmed);
}

sub trim_list{
    my($n, $i) = @_;
    my $trimmer = trimmer($i);
    return trim_list_r($n, $trimmer);
}

MAIN:{
    my(@n, $i);
    $i = 3;
    @n = (1, 4, 2, 3, 5);
    say join(", ", trim_list(\@n, $i));
    $i = 4;
    @n = (9, 0, 6, 2, 3, 8, 5);
    say join(", ", trim_list(\@n, $i));
}