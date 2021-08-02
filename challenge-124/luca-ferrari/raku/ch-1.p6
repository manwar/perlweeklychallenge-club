#!raku

sub MAIN() {
    
    my $venus = qq:to/EOF/;
          ^^^^^
         ^     ^
        ^       ^
       ^         ^
      ^          ^
      ^         ^
      ^        ^
      ^       ^
      ^      ^
      ^      ^
       ^^^^^
         ^
         ^
         ^
       ^^^^^
         ^
         ^
EOF

$venus.say;

}
