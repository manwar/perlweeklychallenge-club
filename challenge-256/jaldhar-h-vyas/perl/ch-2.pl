#!/usr/bin/perl
use 5.030;
use warnings;

sub Ztilde {
    my @a = split //, $_[0];
    my @b = split //, $_[1];
    
    my $remainder = q{};

    if (scalar @a < scalar @b) {
        $remainder = join q{}, splice @b, scalar @a;
    } elsif (scalar @a > scalar @b) {
        $remainder = join q{}, splice @a, scalar @b;
    }

    my @result;
    for my $i (0 .. scalar @b - 1) {
        push @result, $a[$i], $b[$i];
    }
    push @result, $remainder;

    return join q{}, @result;
}

my ($str1, $str2) = @ARGV;

say Ztilde($str1, $str2);
