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

ch-1.pl - Sort String

=head1 SYNOPSIS

  perl ch-1.pl "and2 Raku3 cousins5 Perl1 are4"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a shuffled string, where each word has its (1-based) position appended,
return the words ordered by that position with the digits removed.

=cut

my $STR_CHECK = compile(Str);

sub sort_string ($str) {
    ($str) = $STR_CHECK->($str);

    my @items;
    for my $tok ( split /\s+/, $str ) {
        die "Invalid token: $tok" if $tok !~ /\A(.+?)(\d+)\z/;
        push @items, [ $2 + 0, $1 ];
    }

    return join ' ', map { $_->[1] } sort { $a->[0] <=> $b->[0] } @items;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str = join ' ', @args;
    my $out = sort_string($str);
    say "Input:  \$str = \"$str\"";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            str      => 'and2 Raku3 cousins5 Perl1 are4',
            expected => 'Perl and Raku are cousins',
        },
        {
            label    => 'Example 2',
            str      => 'guest6 Python1 most4 the3 popular5 is2 language7',
            expected => 'Python is the most popular guest language',
        },
        {
            label    => 'Example 3',
            str      => 'Challenge3 The1 Weekly2',
            expected => 'The Weekly Challenge',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( sort_string( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sort_string($str)

Returns the unshuffled sentence.

=cut

