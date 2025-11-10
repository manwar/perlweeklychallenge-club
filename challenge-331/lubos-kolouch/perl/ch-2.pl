#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 PURPOSE

Decide whether two strings are buddy strings, i.e. whether exactly one swap of
two characters in C<$source> can produce C<$target>. Identical strings are
considered buddies if any character occurs more than once.

=head1 ALGORITHM

Inputs are validated with L<Type::Params>. If lengths differ we immediately
return false. Otherwise we collect positions where the characters differ; more
than two mismatches disqualify the pair. Two mismatches form buddies when the
characters cross-match, while zero mismatches form buddies only if the string
contains a duplicate character.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub are_buddy_strings ( $source, $target ) {
    state $check = compile( Str, Str );
    my ( $src, $tgt ) = $check->( $source, $target );

    return 0 if length($src) != length($tgt);

    my @diff;
    for my $idx ( 0 .. length($src) - 1 ) {
        my $s_char = substr $src, $idx, 1;
        my $t_char = substr $tgt, $idx, 1;
        next if $s_char eq $t_char;

        push @diff, [ $s_char, $t_char ];
        return 0 if @diff > 2;
    }

    if ( @diff == 0 ) {
        my %seen;
        for my $char ( split //, $src ) {
            return 1 if ++$seen{$char} > 1;
        }
        return 0;
    }

    return
         @diff == 2
      && $diff[0][0] eq $diff[1][1]
      && $diff[0][1] eq $diff[1][0];
}

# Examples supplied by the specification.
is( are_buddy_strings( 'fuck', 'fcuk' ), 1, 'Example 1' );
is( are_buddy_strings( 'love', 'love' ), 0, 'Example 2' );
is( are_buddy_strings( 'fodo', 'food' ), 1, 'Example 3' );
is( are_buddy_strings( 'feed', 'feed' ), 1, 'Example 4' );

done_testing();
