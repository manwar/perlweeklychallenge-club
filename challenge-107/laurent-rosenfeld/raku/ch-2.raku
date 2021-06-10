use v6;

sub MAIN (Str $file-name) {
     for $file-name.IO.lines -> $line {
        say ~$0 if $line ~~ /^\s* method \s+ (<[-'\w]>+)/;
    }
}
