#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - Goat Latin

=head1 SYNOPSIS

  perl ch-1.pl "I love Perl"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Convert a sentence to Goat Latin:

1) If a word begins with a vowel, append "ma".
2) Otherwise move the first letter to the end, then append "ma".
3) Append 'a' repeated by the 1-based word index.

=cut

my $STR_CHECK = compile(Str);

sub goat_latin ($sentence) {
    ($sentence) = $STR_CHECK->($sentence);
    my @words = split /\s+/, $sentence;

    my @out;
    for my $i ( 0 .. $#words ) {
        my $w = $words[$i];
        if ( $w =~ /\A[aeiou]/i ) {
            $w .= 'ma';
        }
        else {
            my $first = substr( $w, 0, 1, '' );
            $w .= $first . 'ma';
        }
        $w .= 'a' x ( $i + 1 );
        push @out, $w;
    }

    return join ' ', @out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $sentence = join ' ', @args;
    my $out      = goat_latin($sentence);
    say "Input:  \$sentence = \"$sentence\"";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', sentence => 'I love Perl', expected => 'Imaa ovelmaaa erlPmaaaa' },
        {
            label    => 'Example 2',
            sentence => 'Perl and Raku are friends',
            expected => 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa',
        },
        {
            label    => 'Example 3',
            sentence => 'The Weekly Challenge',
            expected => 'heTmaa eeklyWmaaa hallengeCmaaaa',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( goat_latin( $case->{sentence} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 goat_latin($sentence)

Returns the Goat Latin conversion.

=cut

