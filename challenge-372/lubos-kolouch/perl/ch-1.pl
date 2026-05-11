#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=head1 NAME

ch-1.pl - Rearrange Spaces

=head1 SYNOPSIS

  perl ch-1.pl "  challenge  "
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Rearrange spaces so that there is an equal number of spaces between every pair
of adjacent words and that number is maximised. Extra spaces go at the end.

=cut

sub rearrange_spaces ($str) {
    my $num_spaces = ( $str =~ tr/ // );
    my @words      = grep { length($_) } split /\s+/, $str;
    my $num_words  = scalar @words;

    if ( $num_words == 1 ) {
        return $words[0] . ( ' ' x $num_spaces );
    }

    my $num_gaps       = $num_words - 1;
    my $spaces_per_gap = int( $num_spaces / $num_gaps );
    my $remainder      = $num_spaces % $num_gaps;

    return join( ( ' ' x $spaces_per_gap ), @words ) . ( ' ' x $remainder );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str    = join ' ', @args;
    my $result = rearrange_spaces($str);
    say qq{"$result"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => "  challenge  ",             expected => "challenge    " },
        { label => 'Example 2', str => "coding  is  fun",           expected => "coding  is  fun" },
        { label => 'Example 3', str => "a b c  d",                  expected => "a b c d " },
        { label => 'Example 4', str => "  team      pwc  ",         expected => "team          pwc" },
        { label => 'Example 5', str => "   the  weekly  challenge  ", expected => "the    weekly    challenge " },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( rearrange_spaces( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);
