#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 322 Task 1: String Format
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub string_format_re_d_btof( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    while ( $str =~ s/(.{1,$i})$// ) {
        push @chunks, $1;
    }
    return join "-", reverse @chunks;
}

sub string_format_re_nd_rev_ftob( $str, $i ) {
    $str = reverse $str =~ s/-//gr;
    my @chunks;
    push @chunks, $&
        while $str =~ /.{1,$i}/g;
    return scalar reverse join "-", @chunks;
}

sub string_format_nd_ftob( $str, $i ) {
    $str =~ s/-//g;
    my $offset = ( length( $str ) - 1 ) % $i + 1;
    my @chunks = ( substr $str, 0, $offset );
    while ( $offset < length( $str ) ) {
        push @chunks, substr( $str, $offset, $i );
        $offset += $i;
    }
    return join "-", @chunks;
}

sub string_format_d_btof_unshift( $str, $i ) {
    $str =~ s/-//g;
    my ( $tail, @chunks );
    unshift @chunks, $tail
        while $tail = substr $str, -$i, $i, "";
    return join "-", @chunks;
}

sub string_format_d_btof_push_rev( $str, $i ) {
    $str =~ s/-//g;
    my ( $tail, @chunks );
    push @chunks, $tail
        while $tail = substr $str, -$i, $i, "";
    return join "-", reverse @chunks;
}

sub string_format_nd_btof_push_rev( $str, $i ) {
    $str =~ s/-//g;
    my ( @chunks, $index );
    for ( $index = length( $str ) - $i; $index >= 0; $index -= $i ) {
        push @chunks, substr $str, $index, $i;
    }
    if ( $index > -$i ) {
        push @chunks, substr $str, 0, length( $str ) % $i;
    }
    return join "-", reverse @chunks;
}

sub string_format_nd_tail_push_rev( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    for ( my $index = length( $str ) - $i; $index > 0; $index -= $i ) {
        push @chunks, substr $str, $index, $i;
    }
    push @chunks, substr( $str, 0, ( length( $str ) - 1 ) % $i + 1 );
    return join "-", reverse @chunks;
}

sub string_format_nd_nomy_tail_push_rev( $str, $i ) {
    $str =~ s/-//g;
    my ( @chunks, $index );
    for ( $index = length( $str ) - $i; $index > 0; $index -= $i ) {
        push @chunks, substr $str, $index, $i;
    }
    push @chunks, substr( $str, 0, ( length( $str ) - 1 ) % $i + 1 );
    return join "-", reverse @chunks;
}

sub string_format_nd_nomy_tail_push_rev_inline_while( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    my $index = length( $str ) - $i;
    while ( $index > 0 ) {
        push @chunks, substr $str, $index, $i;
    }
    continue {
        $index -= $i;
    }
    return join "-",
        reverse @chunks, substr( $str, 0, $i + $index );
}

sub string_format_nd_nomy_tail_push_rev_inline_wnc( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    my $index = length( $str ) - $i;
    while ( $index > 0 ) {
        push @chunks, substr $str, $index, $i;
        $index -= $i;
    }
    return join "-",
        reverse @chunks, substr( $str, 0, $i + $index );
}

sub string_format_nd_nomy_tail_push_rev_inline_w( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    my $index = length( $str );
    push @chunks, substr $str, $index -= $i, $i
        while $index > $i;
    push @chunks, substr( $str, 0, $index );
    return join "-", reverse @chunks;
}

sub string_format_nd_nomy_tail_push_rev_inline_w_nopush( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    my $index = length( $str );
    push @chunks, substr $str, $index -= $i, $i
        while $index > $i;
    return join "-", reverse @chunks, substr( $str, 0, $index );
}

*string_format = \&string_format_nd_nomy_tail_push_rev_inline_w_nopush;

#
#   Flexible testing.
#

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my $sub_name = "string_format";
my @tests = (
    [ "Example 1:", [ "ABC-D-E-F", 3 ], [ "ABC-DEF" ] ],
    [ "Example 2:", [ "A-BC-D-E", 2 ], [ "A-BC-DE" ] ],
    [ "Example 3:", [ "-A-B-CD-E", 4 ], [ "A-BCDE" ] ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
# for my $sub ( "string_format_nd_nomy_tail_push_rev_inline_w" ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $expected ) = $_->@*;
        $descr .= " $sub" . pp( $input->@* ) . " == "
            . pp $expected->@*
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        is [ $sub->( $input->@* ) ], $expected, $descr;
    }
}

done_testing;

__END__


use Benchmark qw( :all :hireswallclock );

my $str = join "", 1..102;

cmpthese( -5, {
    re_d_btof =>
        sub { string_format_re_d_btof( $str, 4 ) },
    re_nd_rev_ftob =>
        sub { string_format_re_nd_rev_ftob( $str, 4 ) },

    d_btof_unshift =>
        sub { string_format_d_btof_unshift( $str, 4 ) },
    d_btof_push_rev =>
        sub { string_format_d_btof_push_rev( $str, 4 ) },

    nd_ftob =>
        sub { string_format_nd_ftob( $str, 4 ) },
    nd_btof_push_rev =>
        sub { string_format_nd_btof_push_rev( $str, 4 ) },
    nd_tail_push_rev =>
        sub { string_format_nd_tail_push_rev( $str, 4 ) },
    nd_nomy_tail_push_rev =>
        sub { string_format_nd_nomy_tail_push_rev( $str, 4 ) },
    nd_nomy_tail_push_rev_inline_while =>
        sub { string_format_nd_nomy_tail_push_rev_inline_while( $str, 4 ) },
    nd_nomy_tail_push_rev_inline_wnc =>
        sub { string_format_nd_nomy_tail_push_rev_inline_wnc( $str, 4 ) },
    nd_nomy_tail_push_rev_inline_w =>
        sub { string_format_nd_nomy_tail_push_rev_inline_w( $str, 4 ) },
    nd_nomy_tail_push_rev_inline_w_nopush =>
        sub { string_format_nd_nomy_tail_push_rev_inline_w_nopush( $str, 4 ) },
} );
