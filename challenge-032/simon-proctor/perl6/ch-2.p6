#!/usr/bin/env perl6

use v6;

enum SortType <value key>;
enum SortDir <asc desc>;
subset ValidFile of Str where *.IO.f;
my %*SUB-MAIN-OPTS = :named-anywhere;

#| Print help text
multi sub MAIN( Bool :h($help) where so * ) {
    say $*USAGE;
}

sub read-data( IO::CatHandle $files, Bool $csv ) {
    my &line-reader = $csv ?? &parse-csv !! &parse-space-sep;
    my %results := BagHash.new();
    $files.lines.map( &line-reader ).map( -> ( $k, $v ) { %results{$k} = $v } );
    return %results;
}

#| Read data from standard out.
#| Prints a bar chart of the data
multi sub MAIN(
    Bool :$csv = False, #= Input in CSV
    SortType :$sort-type=value, #= Sort Type
    SortDir  :$sort-dir=desc, #= Sort Direction    
) {
    draw-graph( read-data( IO::CatHandle.new( $*IN ), $csv ), $sort-type, $sort-dir );
}

#| Given a list of filenames reads each in turn
multi sub MAIN(
    *@files where all(@files) ~~ ValidFile, #= Files to read
    Bool :$csv = False, #= Output in CSV
    SortType :$sort-type=value, #= Sort Type
    SortDir  :$sort-dir=desc, #= Sort Direction    
) {
    draw-graph( read-data( IO::CatHandle.new( @files ), $csv ), $sort-type, $sort-dir );
}

sub draw-graph( %data, SortType $sort-type, SortDir $sort-dir ) {
    my $k-width = %data.keys.map(*.codes).max;
    my $max-val = %data.values.max;
    my $screen-width = get-screen-width();

    my &sorter = make-sorter( $sort-type, $sort-dir );
    
    my $available = $screen-width - $k-width - 5;
    .say for %data.sort( &sorter ).map( { sprintf( "% -{$k-width}s  |  %s", $_.key, get-bar( $available, $max-val, $_.value ) ) } );
} 

sub make-sorter( SortType $sort-type, SortDir $sort-dir ) {
    given $sort-dir {
        when asc {
            -> $a, $b { $a.^lookup($sort-type)($a) cmp $b.^lookup($sort-type)($b) }
        }
        when desc {
            -> $a, $b { $b.^lookup($sort-type)($b) cmp $a.^lookup($sort-type)($a) }
        }
    }
}

sub get-bar( Int $available, $max, $value ) {
    '#' x ceiling( $available * ( $value / $max ) );
}

sub get-screen-width() {
    run("tput","cols",:out).out.slurp.chomp;
}

sub parse-space-sep( Str $line ) {
    if ( my $match = $line ~~ m!^ (\S+) \s+ (\S+) $! ) {
        return $match[0], $match[1];
    }
    die "Line parser didn't work on $line";
}

sub parse-csv( Str $line ) {
    if ( my $match = $line ~~ m!^ (\"?) (.+) $0 "," (.+) $! ) { #" Editor bug
       return $match[1], $match[2];
    }
    die "Lazy CSV parser didn't work on $line";
}   
