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

ch-1.pl - Power String

=head1 SYNOPSIS

  perl ch-1.pl <string>
  perl ch-1.pl         # runs the embedded tests

=head1 DESCRIPTION

Computes the power of a string, i.e. the maximum length of a contiguous
substring that consists of a single repeated character. The implementation
keeps the core logic inside L</power_string> so both the command line
interface and the unit tests reuse the same routine.

=cut

my $STR_CHECK = compile(Str);

sub power_string ($text) {
    ($text) = $STR_CHECK->($text);
    die 'Expected a non-empty string' if length $text == 0;
    my $max_run = 0;
    my $run_len = 0;
    my $prev    = undef;

    for my $char ( split //, $text ) {
        if ( defined $prev && $char eq $prev ) {
            ++$run_len;
        }
        else {
            $prev    = $char;
            $run_len = 1;
        }
        $max_run = $run_len if $run_len > $max_run;
    }

    return $max_run;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <string>\n" if @args != 1;
    my $input  = $args[0];
    my $result = power_string($input);
    say qq{Input:  \$str = "$input"};
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', input => 'textbook',             expected => 2 },
        { label => 'Example 2', input => 'aaaaa',                expected => 5 },
        { label => 'Example 3', input => 'hoorayyy',             expected => 3 },
        { label => 'Example 4', input => 'x',                    expected => 1 },
        { label => 'Example 5', input => 'aabcccddeeffffghijjk', expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = power_string( $case->{input} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 power_string($text)

Returns the maximum length of a contiguous substring made of one repeated
character. Throws an exception when invoked with an empty string.

=cut
