use v6;

sub is-binary ($file) {
    my constant non-printable-bytes = (0..8).Set (|) (14..31).Set;
    my constant block-size = 4096;
    my $fh = $file.IO.open(:r, :bin);
    my $buf = $fh.read(block-size);
    $fh.close;
    my ($printable, $non-printable) = 0, 0;
    for $buf.list -> $byte {
        return True if $byte == 0; # null byte
        if $byte (elem) non-printable-bytes {
            $non-printable++;
        } else {
            $printable++;
        }
    }
    return True if $non-printable * 31 > $printable;
    False;
}

sub MAIN ($file) {
    die "File $file does not exist" unless $file.IO ~~ :e;
    die "File $file is empty" if $file.IO ~~ :z;
    die "File $file isn't a plain file" unless $file.IO ~~ :f;
    say is-binary($file) ?? "File content is binary" !! "File content is text (ASCII)";
}
