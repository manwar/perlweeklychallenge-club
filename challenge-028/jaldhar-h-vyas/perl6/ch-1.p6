#!/usr/bin/perl6

sub isText(IO::Path $file) {
    my Buf $firstBlock;

    given $file.open {
        $firstBlock = .read;
        .close;
    }

    try {
        $firstBlock.decode('utf-8');
        CATCH {
            return False;
        }
    }

    return True;
}

sub MAIN( Str $arg) {
    say 'The file content is ', isText($arg.IO) ?? 'text.' !! 'binary.';
}