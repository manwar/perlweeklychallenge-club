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

ch-1.pl - Defang IP Address

=head1 SYNOPSIS

  perl ch-1.pl 1.1.1.1
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a valid IPv4 address, return its defanged version by replacing each
period '.' with '[.]'.

=cut

my $STR_CHECK = compile(Str);

sub defang_ip ($ip) {
    ($ip) = $STR_CHECK->($ip);
    ( my $out = $ip ) =~ s/\./[.]/g;
    return $out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <ip>\n" if @args != 1;
    my $ip  = $args[0];
    my $out = defang_ip($ip);
    say "Input:  \$ip = \"$ip\"";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ip => '1.1.1.1',     expected => '1[.]1[.]1[.]1' },
        { label => 'Example 2', ip => '255.101.1.0', expected => '255[.]101[.]1[.]0' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( defang_ip( $case->{ip} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 defang_ip($ip)

Returns the defanged IP address.

=cut

