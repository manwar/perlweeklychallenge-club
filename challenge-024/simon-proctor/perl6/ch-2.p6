#!/usr/bin/env perl6

use v6;
use JSON::Fast;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Display Help information
multi sub MAIN ( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

subset FileExists of Str where { $_.IO.e && $_.IO.f };   

#| Work out the reverse index for the given documents
multi sub MAIN (
    *@documents where { @documents.all ~~ FileExists }, #= List of documents to process
    Int :$min-length = 3, #= Minimum word length to count for inclusion in the index. Default is 3 characters.
) {
    my %index;
    my $word-channel = Channel.new;
    my @promises;
    my $promise-count++;
    
    for @documents -> $path {
        @promises.push(
            start {
                my $res-path = $path.IO.resolve.Str;
                for $path.IO.words -> $word is copy {
                    $word ~~ s:g!<[\W]>!!;
                    next unless $word.chars >= $min-length;
                    $word-channel.send( ( $word.fc, $res-path ) );
                }
            }
        );
    }
    
    my $reactor = start react {
        whenever $word-channel -> ( $word, $path ) {
            %index{$word} //= SetHash.new;
            %index{$word}.{$path} = True;
        }
    }
    await @promises;
    $word-channel.close;
    await $reactor;
    
    %index = %index.map( { $_.key => $_.value.keys } );
    say to-json( %index );
}

