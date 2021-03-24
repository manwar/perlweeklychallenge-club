#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;

my @letters    = 'A' .. 'Z';
my @vowels     = qw{ A E I O U };
my %vowels     = map  { $_ => 1 } @vowels;
my @consonants = grep { !$vowels{$_} } @letters;
my %consonants = map  { $_ => 1 } @consonants;

my $name = 'Katie';
GetOptions( 'name=s' => \$name );

name_game($name);

sub name_game( $name ) {
    my $Name = ucfirst lc $name;
    croak "Can't do 'Chuck'" if lc $name eq 'chuck';
    my $i      = substr( $Name, 0, 1 );
    my ($init) = $Name =~ m{^([^AEIOU]+)}mix;
    my $y      = $Name;
    $y =~ s{^([^AEIOU]+)}{}mix;

    my $by = 'B' . $y;
    my $fy = 'F' . $y;
    my $my = 'M' . $y;

    if (0) { }
    if ( $vowels{$i} ) {
        $init = '';
        $by   = 'B' . lc($Name);
        $fy   = 'F' . lc($Name);
        $my   = 'M' . lc($Name);
    }
    elsif ( $init eq 'B' ) {
        $by = ucfirst $y;
    }
    elsif ( $init eq 'F' ) {
        $fy = ucfirst $y;
    }
    elsif ( $init eq 'M' ) {
        $my = ucfirst $y;
    }
    say <<"END";
        $Name, $Name, bo-$by
        Bonanna-fanna fo-$fy
        Fee fi mo-$my
        $Name!
END
}

