#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int Str);

=pod

=head1 NAME

ch-2.pl - Group Digit Sum

=head1 SYNOPSIS

  perl ch-2.pl 111122333 3
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Repeatedly partition the digit string into chunks of size C<$int> (last chunk
may be shorter), sum digits within each chunk and concatenate the sums to form a
new string. Stop once the new string length is less than or equal to C<$int>.

=cut

my $ARGS_CHECK = compile( Str, Int );

sub _sum_digits ($chunk) {
    my $sum = 0;
    $sum += $_ for split //, $chunk;
    return $sum;
}

sub group_digit_sum ($str, $int) {
    ( $str, $int ) = $ARGS_CHECK->( $str, $int );
    die 'Expected $int > 0' if $int <= 0;
    die 'Expected digits only' if $str =~ /[^0-9]/;

    while ( length($str) > $int ) {
        my @parts;
        for ( my $i = 0; $i < length($str); $i += $int ) {
            push @parts, substr( $str, $i, $int );
        }
        $str = join '', map { _sum_digits($_) } @parts;
    }

    return $str;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <digits> <int>\n" if @args != 2;

    my ( $str, $int ) = @args;
    my $out = group_digit_sum( $str, 0 + $int );
    say qq{Input: \$str = "$str", \$int = $int};
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => '111122333',    int => 3, expected => '359' },
        { label => 'Example 2', str => '1222312',      int => 2, expected => '76' },
        { label => 'Example 3', str => '100012121001', int => 4, expected => '162' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( group_digit_sum( $case->{str}, $case->{int} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 group_digit_sum($str, $int)

Returns the final digit string after repeatedly grouping and summing digits.

=cut
