#!/usr/bin/env perl

# Perl Weekly Challenge 170 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

use Modern::Perl;

# current input line in $_
sub parse_matrix {
    my @a;
    s/^\s*\w+\s*=\s*// or die "assignment expected: $_";
    while (defined $_) {
        /\s*\[([\s\d]+)\]\s*$/ or last;
        my @row = split(' ', $1);
        push @a, \@row;
        $_=<>;
    }
    return @a;
}

sub parse_input {
    $_ = "";
    $_=<> while /^\s*$/;
    my @a = parse_matrix();
    $_=<> while /^\s*$/;
    my @b = parse_matrix();
    return \@a, \@b;
}

sub kronecker_product {
    my($a, $b) = @_;
    my $wa = @{$a->[0]}; my $ha = @$a;
    my $wb = @{$b->[0]}; my $hb = @$b;
    my @prod;
    for my $ar (0..$ha-1) {
        for my $ac (0..$wa-1) {
            for my $br (0..$hb-1) {
                for my $bc (0..$wb-1) {
                    my $tr = $ar*$hb + $br;
                    my $tc = $ac*$wb + $bc;
                    $prod[$tr] ||= [];
                    $prod[$tr][$tc] = $a->[$ar][$ac] * $b->[$br][$bc];
                }
            }
        }
    }
    return @prod;
}

sub print_matrix {
    my(@a) = @_;
    for my $i (0 .. $#a) {
        my $row = $a[$i];
        print $i==0 ? "[" : " ";
        print "[ ";
        print join(", ", map {sprintf("%2d", $_)} @$row);
        print " ]";
        print $i==$#a ? "]" : ",";
        print "\n";
    }
}

print_matrix(kronecker_product(parse_input()));
