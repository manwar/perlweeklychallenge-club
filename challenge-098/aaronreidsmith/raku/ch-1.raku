#!/usr/bin/env raku

sub readN(Str $file-name, Int $chars-to-read where $chars-to-read > 0) returns Str {
    state %file-map;

    if %file-map{$file-name}:!exists {
        %file-map{$file-name} = IO::CatHandle.new($file-name)
    }

    %file-map{$file-name}.readchars($chars-to-read);
}

multi sub MAIN(Str $FILE, Int $N) {
    say readN($FILE, $N);
    say readN($FILE, $N);
    say readN($FILE, $N);
}

multi sub MAIN(Bool :$test) {
    use Test;

    # Create a file for testing
    my $test-file = 'test.txt';
    $test-file.IO.spurt('1234567890');

    is(readN($test-file, 4), '1234');
    is(readN($test-file, 4), '5678');
    is(readN($test-file, 4), '90');

    # Delete when we're done
    $test-file.IO.unlink;

    done-testing;
}
