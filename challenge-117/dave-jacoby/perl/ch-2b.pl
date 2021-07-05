#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ uniq };
use Algorithm::Permute;

my $n = 2;
GetOptions( 'number=i' => \$n );
croak 'Too Small' if $n < 0;

my @solutions = solve_triangle($n);
# say join ' ', ( scalar @solutions ), @solutions, ( scalar @solutions );

sub solve_triangle ( $n ) {
    my @output;
    my $string = 'R' x $n;
    push @output, $string;
    my %hash;
    my $c = 1;
    while ( $string =~ /R/ ) {
        $string =~ s/R/LH/;
        my @list = split //, $string;
        my $p    = Algorithm::Permute->new( \@list );
        while ( my @res = $p->next ) {
            my $x = join '', @res;
            next if $x =~ m{^H|L$};
            # push @output, $x;
            next if $hash{$x}++;
            say join "\t", $c, $x ;
            $c++;
        }
    }
    return sort { length $b <=> length $a } uniq @output;
}
