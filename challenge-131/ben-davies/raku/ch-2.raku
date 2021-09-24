use v6;
unit sub MAIN(Str:D $delims where .chars %% 2, Str:D $text) {
    m/ [ $<opener>=. $<closer>=. ]* / given $delims;
    my @opener := @<opener>;
    my @closer := @<closer>;
    say $text.match(/ @opener /, :g).join;
    say $text.match(/ @closer /, :g).join;
}
