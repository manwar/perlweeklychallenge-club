#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Max Str Value

=head1 SYNOPSIS

  perl ch-1.pl                 # runs the embedded tests
  perl ch-1.pl 123 abc 007     # prints the maximum value

=head1 DESCRIPTION

Given an array of alphanumeric strings, compute each string's value:

- if the string contains digits only, its numeric value (leading zeros allowed)
- otherwise, the length of the string

Return the maximum value.

=cut

sub str_value ($s) {
    return 0 + $s if $s =~ /\A\d+\z/;
    return length $s;
}

sub max_str_value (@strings) {
    die "Expected at least one string\n" if !@strings;
    my $max = str_value( $strings[0] );
    for my $s ( @strings[ 1 .. $#strings ] ) {
        my $v = str_value($s);
        $max = $v if $v > $max;
    }
    return $max;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { in => [qw(123 45 6)],            out => 123,  label => 'Example 1' },
        { in => [qw(abc de fghi)],         out => 4,    label => 'Example 2' },
        { in => [qw(0012 99 a1b2c)],       out => 99,   label => 'Example 3' },
        { in => [qw(x 10 xyz 007)],        out => 10,   label => 'Example 4' },
        { in => [qw(hello123 2026 perl)],  out => 2026, label => 'Example 5' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $t (@cases) {
        Test::More::is( max_str_value( @{ $t->{in} } ), $t->{out}, $t->{label} );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    say max_str_value(@args);
}

_run_cli(@ARGV);

