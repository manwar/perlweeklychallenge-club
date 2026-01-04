#!/usr/bin/env perl
use v5.38;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Unicode::Normalize qw(NFD);
use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Unicode Makeover

=head1 SYNOPSIS

  perl ch-2.pl 'ÃÊÍÒÙ'
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Replace unicode alphabetic characters with their ASCII equivalents by
decomposing to NFD and removing combining marks.

=cut

my $STR_CHECK = compile(Str);

sub makeover ($str) {
    ($str) = $STR_CHECK->($str);
    my $nfd = NFD($str);
    $nfd =~ s/\pM//g;
    return $nfd;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str = join ' ', @args;
    my $out = makeover($str);
    say "Input:  \$str = '$str'";
    say "Output: '$out'";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 2 );
    Test::More::is( makeover('ÃÊÍÒÙ'), 'AEIOU', 'Example 1' );
    Test::More::is( makeover('âÊíÒÙ'), 'aEiOU', 'Example 2' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 makeover($str)

Returns the ASCII-normalized string.

=cut

