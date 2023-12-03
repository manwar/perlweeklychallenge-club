use v5.38;
##
# You are given two array of languages and its popularity.
# Write a script to sort the language based on popularity.
##
use Thread;
sub sort_language{
    my @language = @{$_[0]};
    my @popularity = @{$_[1]};
    my @threads;
    do{
        push @threads, Thread->new(
            sub{sleep($popularity[$_]); say $language[$_]}
        );
    } for 0 .. @popularity - 1;
    do{$_ -> join()} for @threads;
}

MAIN:{
    sort_language [qw/perl c python/], [2, 1, 3];
}