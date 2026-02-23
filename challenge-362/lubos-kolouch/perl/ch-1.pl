#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Echo Chamber

=head1 SYNOPSIS

  perl ch-1.pl        # runs the embedded tests
  perl ch-1.pl abca   # prints "abbcccaaaa"

=head1 DESCRIPTION

Given a lowercase string, repeat each character according to its index:
position 0 once, position 1 twice, etc.

=cut

sub echo_chamber ($text) {
    my $out = '';
    for my $i ( 0 .. length($text) - 1 ) {
        my $ch = substr( $text, $i, 1 );
        $out .= $ch x ( $i + 1 );
    }
    return $out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is( echo_chamber('abca'),  'abbcccaaaa',     'Example 1' );
    Test::More::is( echo_chamber('xyz'),   'xyyzzz',         'Example 2' );
    Test::More::is( echo_chamber('code'),  'coodddeeee',     'Example 3' );
    Test::More::is( echo_chamber('hello'), 'heelllllllooooo','Example 4' );
    Test::More::is( echo_chamber('a'),     'a',              'Example 5' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <lowercase-string>\n" if @args != 1;
    say echo_chamber( $args[0] );
}

_run_cli(@ARGV);
