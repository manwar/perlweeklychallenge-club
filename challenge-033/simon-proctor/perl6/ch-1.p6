#!/usr/bin/env perl6
 
use v6;

subset ValidFile of Str where *.IO.f;
my %*SUB-MAIN-OPTS = :named-anywhere;

#| Print help text
multi sub MAIN( Bool :h($help) where so * ) {
    say $*USAGE;
}

#| Read data from standard in.
#| Returns a list of a-z and the number of times each occurs in the input
multi sub MAIN() {
    read-files( IO::CatHandle.new( $*IN ) );
}

#| Given a list of filenames reads each in turn
#| Returns a list of a-z and the number of times each occurs in the input
multi sub MAIN(
    *@files where all(@files) ~~ ValidFile, #= Files to read
) {
    read-files( IO::CatHandle.new( @files ) );
}

sub read-files( IO::CatHandle $files ) {
    my %results := $files.words.map(*.lc.comb()).flat.grep( { $_ ~~ m!<[a..z]>! } ).Bag;
    
    .say for ("a".."z").map( { "{$_} : {%results{$_}}" } );
}
