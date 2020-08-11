#!/usr/bin/env perl6

use v6;

subset ValidFile of Str where *.IO.f;
my %*SUB-MAIN-OPTS = :named-anywhere;

#| Print help text
multi sub MAIN( Bool :h($help) where so * ) {
    say $*USAGE;
}

#| Read date from standard out.
#| Returns a list of name and count sorted by count
multi sub MAIN(
    Bool :$csv = False #= Output in CSV
) {
    read-files( IO::CatHandle.new( $*IN ), $csv );
}

#| Given a list of filenames reads each in turn
multi sub MAIN(
    *@files where all(@files) ~~ ValidFile, #= Files to read
    Bool :$csv = False #= Output in CSV
) {
    read-files( IO::CatHandle.new( @files ), $csv );
}

sub read-files( IO::CatHandle $files, $csv ) {
    my %results := BagHash.new();
    %results{$_}++ for $files.lines;
    my $k-dist = %results.keys.map( *.codes ).max;
    my $v-dist = %results.values.map( *.codes ).max;
    my $fmt = $csv ?? '"%s",%d' !! "% -{$k-dist+2}s%{$v-dist+2}d";
    .say for %results.sort( *.value <=> *.value ).reverse.map( { sprintf($fmt,$_.key,$_.value) } );
}
