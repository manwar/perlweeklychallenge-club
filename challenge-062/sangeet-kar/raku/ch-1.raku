#!/usr/bin/env raku

sub MAIN(Bool :$u=False, *@files){
        my @mails = @files ?? @files.flatmap(*.IO.lines) 
                           !! $*IN.lines;
        @mails».split("@").&{$u ?? .unique(as => {$^a[0] ~ $^a[1].lc}) !! .self}.sort({.[1].lc ~ .[0]})».join("@")».say;
}
