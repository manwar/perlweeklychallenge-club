#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Spellbound Sorting

=head1 SYNOPSIS

  perl ch-2.pl   # runs embedded tests

=head1 DESCRIPTION

Sort integers by alphabetical order of their word forms.
Default language is English; French is supported for the official example.

=cut

sub number_to_words_en ($n) {
    if ( $n < 0 ) {
        return 'minus ' . number_to_words_en( -$n );
    }

    my @units = qw(zero one two three four five six seven eight nine);
    my %teens = (
        10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen',
        14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen',
        18 => 'eighteen', 19 => 'nineteen',
    );
    my %tens = (
        20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
        60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety',
    );

    return $units[$n] if $n < 10;
    return $teens{$n} if $n < 20;

    if ( $n < 100 ) {
        my $t = int( $n / 10 ) * 10;
        my $u = $n % 10;
        return $u == 0 ? $tens{$t} : "$tens{$t}-$units[$u]";
    }

    if ( $n < 1000 ) {
        my $h = int( $n / 100 );
        my $r = $n % 100;
        my $base = "$units[$h] hundred";
        return $r == 0 ? $base : "$base and " . number_to_words_en($r);
    }

    if ( $n < 1_000_000 ) {
        my $th = int( $n / 1000 );
        my $r  = $n % 1000;
        my $base = number_to_words_en($th) . ' thousand';
        return $r == 0 ? $base : "$base " . number_to_words_en($r);
    }

    die "number outside supported range\n";
}

sub number_to_words_fr ($n) {
    my %small = ( 0 => 'zero', 1 => 'un', 2 => 'deux', 3 => 'trois', 4 => 'quatre', 5 => 'cinq' );

    if ( $n < 0 ) {
        return 'moins ' . number_to_words_fr( -$n );
    }

    return $small{$n} if exists $small{$n};
    die "French conversion currently supports only -5..5 in examples\n";
}

sub spellbound_sort ( $numbers, $lang = 'en' ) {
    my %words;
    for my $n (@$numbers) {
        if ( $lang eq 'en' ) {
            $words{$n} = number_to_words_en($n);
        }
        elsif ( $lang eq 'fr' ) {
            $words{$n} = number_to_words_fr($n);
        }
        else {
            die "Unsupported language; use 'en' or 'fr'\n";
        }
    }

    my @sorted = sort { $words{$a} cmp $words{$b} } @$numbers;
    return \@sorted;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is_deeply( spellbound_sort( [ 6, 7, 8, 9, 10 ] ), [ 8, 9, 7, 6, 10 ], 'Example 1' );
    Test::More::is_deeply( spellbound_sort( [ -3, 0, 1000, 99 ] ), [ -3, 99, 1000, 0 ], 'Example 2' );
    Test::More::is_deeply( spellbound_sort( [ 1, 2, 3, 4, 5 ], 'fr' ), [ 5, 2, 4, 3, 1 ], 'Example 3 French' );
    Test::More::is_deeply( spellbound_sort( [ 1, 2, 3, 4, 5 ] ), [ 5, 4, 1, 3, 2 ], 'Example 3 English' );
    Test::More::is_deeply( spellbound_sort( [ 0, -1, -2, -3, -4 ] ), [ -4, -1, -3, -2, 0 ], 'Example 4' );
    Test::More::is_deeply( spellbound_sort( [ 100, 101, 102 ] ), [ 100, 101, 102 ], 'Example 5' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Run without arguments to execute embedded tests.\n";
}

_run_cli(@ARGV);
