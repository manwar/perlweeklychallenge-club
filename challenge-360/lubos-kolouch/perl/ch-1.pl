#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Text Justifier

=head1 SYNOPSIS

  perl ch-1.pl                      # runs the embedded tests
  perl ch-1.pl 10 "Code"            # prints "***Code***"

=head1 DESCRIPTION

Given a string and a width, center the string within that width using asterisks
(C<*>) as padding. If padding is odd, put the extra star on the right.

=cut

sub text_justifier ( $str, $width ) {
    die "Width must be a non-negative integer\n" if $width !~ /^\d+$/;

    my $len = length($str);
    return $str if $width <= $len;

    my $pad   = $width - $len;
    my $left  = int( $pad / 2 );
    my $right = $pad - $left;

    return ( '*' x $left ) . $str . ( '*' x $right );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is( text_justifier( 'Hi',    5 ), '*Hi**',      'Example 1' );
    Test::More::is( text_justifier( 'Code',  10 ), '***Code***', 'Example 2' );
    Test::More::is( text_justifier( 'Hello', 9 ), '**Hello**',  'Example 3' );
    Test::More::is( text_justifier( 'Perl',  4 ), 'Perl',       'Example 4' );
    Test::More::is( text_justifier( 'A',     7 ), '***A***',    'Example 5' );
    Test::More::is( text_justifier( '',      5 ), '*****',      'Example 6' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <width> <str>\n" if @args < 1;
    my $width = shift @args;
    my $str   = join ' ', @args;
    say text_justifier( $str, $width );
}

_run_cli(@ARGV);

