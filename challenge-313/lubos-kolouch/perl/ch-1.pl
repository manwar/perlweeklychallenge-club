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

ch-1.pl - Broken Keys

=head1 SYNOPSIS

  perl ch-1.pl perl perrrl
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Checks whether the typed string could have been produced from the intended name
when a key can be long-pressed, i.e. a character may appear repeated one or
more times consecutively.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub is_long_pressed ($name, $typed) {
    ( $name, $typed ) = $ARGS_CHECK->( $name, $typed );
    return 0 if length($typed) < length($name);

    my @n = split //, $name;
    my @t = split //, $typed;
    my $i = 0;
    my $j = 0;

    while ( $j <= $#t ) {
        if ( $i <= $#n && $n[$i] eq $t[$j] ) {
            ++$i;
            ++$j;
        }
        elsif ( $j > 0 && $t[$j] eq $t[ $j - 1 ] ) {
            ++$j;
        }
        else {
            return 0;
        }
    }

    return $i == @n ? 1 : 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <name> <typed>\n" if @args != 2;

    my ( $name, $typed ) = @args;
    my $out = is_long_pressed( $name, $typed ) ? 'true' : 'false';
    say qq{Input: \$name = "$name", \$typed = "$typed"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', name => 'perl',        typed => 'perrrl',          expected => 1 },
        { label => 'Example 2', name => 'raku',        typed => 'rrakuuuu',        expected => 1 },
        { label => 'Example 3', name => 'python',      typed => 'perl',            expected => 0 },
        { label => 'Example 4', name => 'coffeescript', typed => 'cofffeescccript', expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = is_long_pressed( $case->{name}, $case->{typed} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_long_pressed($name, $typed)

Returns a boolean indicating whether C<$typed> can be produced from C<$name>
using long presses.

=cut
