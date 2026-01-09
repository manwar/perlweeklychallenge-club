#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-1.pl - Thousand Separator

=head1 SYNOPSIS

  perl ch-1.pl 12345
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a positive integer, format it with a thousands separator (comma) and
return the resulting string.

=cut

my $INT_CHECK = compile(Int);

sub thousand_separator ($int) {
    ($int) = $INT_CHECK->($int);
    die 'Expected a positive integer' if $int <= 0;

    my $s = reverse "$int";
    $s =~ s/(\d{3})(?=\d)/$1,/g;
    return scalar reverse $s;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <int>\n" if @args != 1;
    my $int = 0 + $args[0];
    my $out = thousand_separator($int);
    say "Input:  \$int = $int";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', int => 123,     expected => '123' },
        { label => 'Example 2', int => 1234,    expected => '1,234' },
        { label => 'Example 3', int => 1000000, expected => '1,000,000' },
        { label => 'Example 4', int => 1,       expected => '1' },
        { label => 'Example 5', int => 12345,   expected => '12,345' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( thousand_separator( $case->{int} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 thousand_separator($int)

Returns the formatted number with commas as thousands separators.

=cut

