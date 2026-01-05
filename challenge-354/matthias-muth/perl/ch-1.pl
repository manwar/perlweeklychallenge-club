#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 354 Task 1: Min Abs Diff
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( min );
use List::MoreUtils qw( slide );

sub min_abs_diff( $ints ) {
    $ints->@* > 1 or return ();
    my @pairs = slide { [ $a, $b ] } sort { $a <=> $b } $ints->@*;
    my $min_diff = min( map $_->[1] - $_->[0], @pairs );
    return grep $_->[1] - $_->[0] == $min_diff, @pairs;
}

sub X_min_abs_diff_2( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my $min_diff = min( map $_->[1] - $_->[0], @pairs );
    return grep $_->[1] - $_->[0] == $min_diff, @pairs;
}

sub X_min_abs_diff_slide_map( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my @diffs = map { $sorted[$_] - $sorted[ $_ - 1 ] } 1..$#sorted;
    my $min_diff = min( @diffs );
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @pairs;
}

sub min_abs_diff_2_slides( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my @diffs = slide { $b - $a }    @sorted;
    my $min_diff = min( @diffs );
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @pairs;
}

sub X_min_abs_diff_2_slides_2( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my @diffs = slide { $b - $a }    @sorted;
    my $min_diff = min( @diffs );
    return grep $_->[1] - $_->[0] == $min_diff, @pairs;
}

sub X_min_abs_diff_2_slides_3( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my @diffs = slide { $b - $a }    @sorted;
    my $min_diff = $diffs[0];
    my @results;
    (
        $diffs[$_] < $min_diff
        ? (  $min_diff = $diffs[$_], @results = ( $pairs[$_] ) )
        : ( $diffs[$_] == $min_diff and push @results, $pairs[$_] )
    ) for keys @pairs;
    return @results;
}

# Separate diff array
sub X_min_abs_diff_array( $ints ) {
    $ints->@* > 1 or return ();
    my @pairs = slide { [ $a, $b ] } sort { $a <=> $b } $ints->@*;
    my $min_diff = $pairs[0][1] - $pairs[0][0];
    my @diffs = map {
        my $diff = $_->[1] - $_->[0];
        $min_diff = $diff
            if $diff < $min_diff;
        $diff
    } @pairs;
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @pairs;
}

# Schwartzian
sub X_min_abs_diff_schw_1( $ints ) {
    $ints->@* > 1 or return ();
    my @schwartzian =
        slide { [ $b - $a, [ $a, $b ] ] } sort { $a <=> $b } $ints->@*;
    my $min_diff = min( map $_->[0], @schwartzian );
    return map $_->[1], grep $_->[0] == $min_diff, @schwartzian;
}

# Schwartzian 2
sub X_min_abs_diff_schw_1b( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @schwartzian = slide { [ $b - $a, [ $a, $b ] ] } @sorted;
    my $min_diff = min( map $_->[0], @schwartzian );
    return map $_->[1], grep $_->[0] == $min_diff, @schwartzian;
}

# Schwartzian integrated min
sub X_min_abs_diff_schw_2( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my $min_diff = $sorted[1] - $sorted[0];
    my @schwartzian = slide {
        $min_diff = $b - $a
            if $b - $a < $min_diff;
        [ $b - $a, [ $a, $b ] ]
    } @sorted;
    return map $_->[1], grep $_->[0] == $min_diff, @schwartzian;
}

# Schwartzian triplets
sub min_abs_diff_schw_3( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @schwartzian = slide { [ $b - $a, $a, $b ] } @sorted;
    my $min_diff = min( map $_->[0], @schwartzian );
    return map [ $_->@[1,2] ], grep $_->[0] == $min_diff, @schwartzian;
}

# Schwartzian triplets
sub X_min_abs_diff_schw_3b( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my $min_diff = min( slide { $b - $a } @sorted );
    return
        map [ $_->@[1,2] ],
            grep $_->[0] == $min_diff,
                slide { [ $b - $a, $a, $b ] }
                    @sorted;
}

# Schwartzian tuple (diff, arrayref)
sub X_min_abs_diff_schw_3_ref( $ints ) {
    $ints->@* > 1 or return ();
    my @schwartzian =
        slide { [ $b - $a, [ $a, $b ] ] } sort { $a <=> $b } $ints->@*;
    my $min_diff = min( map $_->[0], @schwartzian );
    return map $_->[1], grep $_->[0] == $min_diff, @schwartzian;
}

# James Curtis-Smith 1
sub min_abs_diff_jcs_1( $ints ) {
    $ints->@* > 1 or return ();
    my ( $f, @x, @m ) = sort  { $a <=> $b } $ints->@*;
    my $min = $x[0] - $f;
    $min > ( $_ - $f )
    ? ( $min = $_ - $f, @m = [ $f, $_ ] )
    : $min < ( $_ - $f ) || ( push @m, [ $f, $_ ] ),
    $f = $_
        for @x;
    @m;
}

# James Curtis-Smith 1 Rewrite
sub min_abs_diff_jcs_rewrite( $ints ) {
    $ints->@* > 1 or return ();
    my ( $prev, @sorted, @results ) = sort  { $a <=> $b } $ints->@*;
    my $min = $sorted[0] - $prev;
    (
        $min > ( $_ - $prev )
        ? ( $min = $_ - $prev, @results = [ $prev, $_ ] )
        : ( $_ - $prev > $min || push @results, [ $prev, $_ ] ),
        $prev = $_
    ) for @sorted;
    return @results;
}

# James Curtis-Smith 2
sub X_min_abs_diff_jcs_2( $ints ) {
    $ints->@* > 1 or return ();
    sub {
        map  { [ $_->@[0,1] ] }
        grep { $_->[2] == $_[0][2] }
        @_
    }->(
        sort  { $a->[2] <=> $b->[2] }
        slide { [ $a, $b, $b - $a ] }
        sort  { $a <=> $b }
        $ints->@*
    );
}


my $sub_base_name = "min_abs_diff";
my @sub_names = sort grep /^${sub_base_name}/, keys %::;

my @tests = (
    [ 'Example 1', [ [ 4, 2, 1, 3 ] ],      [ [1, 2], [2, 3], [3, 4] ] ],
    [ 'Example 2', [ [ 10, 100, 20, 30 ] ], [ [10, 20], [20, 30] ] ],
    [ 'Example 3', [ [ -5, -2, 0, 3 ] ],    [ [-2, 0] ] ],
    [ 'Example 4', [ [ 8, 1, 15, 3 ] ],     [ [1, 3] ] ],
    [ 'Example 5', [ [ 12, 5, 9, 1, 15 ] ], [ [9, 12], [12, 15] ] ],
    [ 'Test 1', [ [] ], [] ],
);

use Getopt::Long;
my ( $do_tests, $do_benchmark );
GetOptions(
    "benchmark!", \$do_benchmark,
    "tests!",     \$do_tests,
) or die "Usage!\n!";
$do_tests //= ! $do_benchmark;

! $do_tests || run_tests( @tests )
    and $do_benchmark && run_benchmark( $sub_base_name, @sub_names );

sub run_tests( @tests ) {
    # This runs the tests not only for the sub named "$sub_base_name",
    # but also for all variants with any suffix ("$sub_base_name<suffix>").
    use Test2::V0 qw( -no_srand );
    for my $sub ( @sub_names ) {
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

    # Get the context and check for failures
    use Test2::API qw( context );
    my $ctx = context();
    my $hub = $ctx->hub;
    $ctx->release;
    return $hub->is_passing;
}

sub run_benchmark( $sub_base_name, @subs ) {
    use Benchmark qw( :all );
    #     srand( 0 );
    my ( $n, $range ) = ( 1000, 100000 );
    my @ints = sort { $a <=> $b } map int( rand( $range ) ), 1..$n;
    no strict 'refs';
    my %subs = map {
        my $id = s/^${sub_base_name}_*(.+)/$1/r;
        my $sub_name = $_;      # to get a closure.
        ( $id => sub { $sub_name->( \@ints ) } )
    } @sub_names;
    cmpthese( -1, \%subs );
}
