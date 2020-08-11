use Data::TextOrBinary;

sub MAIN (
    *@files #= Files to check if ascii/binary
) {
    for @files -> $x {
        if (is-text($x.IO)) {
            say "[$x]: The file content is ascii.";
        } else {
            say "[$x]: The file content is binary.";
        }
    }
}