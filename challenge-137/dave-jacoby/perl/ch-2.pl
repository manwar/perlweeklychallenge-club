#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Math::BigInt;
use Getopt::Long;
use List::Util qw{uniq};

my @examples;
my @numbers;
my $lychrel = 0;
GetOptions(
    'number=i' => \@numbers,
    'lychrel'  => \$lychrel,
);

if ( scalar @numbers ) {
    @examples = uniq sort { $a <=> $b } @numbers;
}
else { @examples = ( 10 .. 1000 ); }

for my $e (@examples) {
    my $l = is_lychrel($e);
    next if !$l && $lychrel;
    say <<"END";
        Input:  \$n = $e
        Output: $l
END
}

exit;

sub is_lychrel($e) {
    my $n = $e;
    my $c = 0;
    while ( !is_palindrome($n) ) {
        $n = lychrel($n);
        $c++;
        return 1 if $c >= 500;
    }
    return 0;
}

sub lychrel( $n ) {
    my $bign = Math::BigInt->new($n);
    my $u    = join '', reverse split //, $n;
    my $bigu = Math::BigInt->new($u);
    my $new  = $bign->badd($bigu);
    return $new;
}

sub is_palindrome ($n) {
    my $u = join '', reverse split //, $n;
    $u =~ s/^0+//mix;
    return $u eq $n ? 1 : 0;
}

