#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=pod

=head1 NAME

ch-2.pl - Wheatstone-Playfair

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Implement encryption and decryption using the Wheatstone-Playfair cipher.
This combines I/J and uses X as padding.

=cut

use Type::Params    qw(compile);
use Types::Standard qw(Int Str);

my $STR_CHECK = compile(Str, Str);

sub _strip ($s) {
    $s = lc $s;
    $s =~ s/[^a-z]//g;
    $s =~ tr/j/i/;
    return $s;
}

sub _posmod ($a, $b) {
    my $m = $a % $b;
    $m += $b while $m < 0;
    return $m;
}

sub _build_square ($keyword) {
    my %seen;
    my $kw = '';
    for my $ch ( split //, _strip($keyword) . join( '', 'a' .. 'z' ) ) {
        $ch = 'i' if $ch eq 'j';
        next if $seen{$ch}++;
        $kw .= $ch;
    }

    my @grid;
    my %pos;
    my $idx = 0;
    for my $r ( 0 .. 4 ) {
        my @row;
        for my $c ( 0 .. 4 ) {
            my $ch = substr( $kw, $idx++, 1 );
            push @row, $ch;
            $pos{$ch} = [ $r, $c ];
        }
        push @grid, \@row;
    }
    return ( \@grid, \%pos );
}

sub _playfair ($dir, $keyword, $input) {
    my ( $grid, $pos ) = _build_square($keyword);
    my $ii = _strip($input);
    my @chars = split //, $ii;
    my $out   = '';

    my $i = 0;
    while ( $i < @chars ) {
        my $a = $chars[$i++];
        my $b = $chars[$i] // 'x';
        if ( defined $chars[$i] ) { $i++ }

        if ( $a eq $b ) {
            $b = 'x';
            $i-- if $i > 0;
        }

        my ( $ar, $ac ) = @{ $pos->{$a} };
        my ( $br, $bc ) = @{ $pos->{$b} };
        my ( $oar, $oac, $obr, $obc ) = ( $ar, $ac, $br, $bc );

        if ( $ar == $br ) {
            $oac = _posmod( $ac + $dir, 5 );
            $obc = _posmod( $bc + $dir, 5 );
        }
        elsif ( $ac == $bc ) {
            $oar = _posmod( $ar + $dir, 5 );
            $obr = _posmod( $br + $dir, 5 );
        }
        else {
            $oac = $bc;
            $obc = $ac;
        }

        $out .= $grid->[$oar][$oac] . $grid->[$obr][$obc];
    }

    return $out;
}

sub encrypt ($keyword, $plaintext) {
    ( $keyword, $plaintext ) = $STR_CHECK->( $keyword, $plaintext );
    return _playfair( 1, $keyword, $plaintext );
}

sub decrypt ($keyword, $ciphertext) {
    ( $keyword, $ciphertext ) = $STR_CHECK->( $keyword, $ciphertext );
    return _playfair( -1, $keyword, $ciphertext );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0  # runs tests only\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 2 );
    Test::More::is(
        encrypt( 'playfair example', 'hide the gold in the tree stump' ),
        'bmodzbxdnabekudmuixmmouvif',
        'Example 1'
    );
    Test::More::is(
        decrypt( 'perl and raku', 'siderwrdulfipaarkcrw' ),
        'thewexeklychallengex',
        'Example 2'
    );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 encrypt($keyword, $plaintext)

Encrypt using the Playfair cipher.

=head2 decrypt($keyword, $ciphertext)

Decrypt using the Playfair cipher.

=cut

