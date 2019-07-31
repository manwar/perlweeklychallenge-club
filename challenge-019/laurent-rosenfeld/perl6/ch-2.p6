use v6;

sub wrap (Str $line is copy, Int $width) {
    my $out = '';
    while ($line) {
        return $out ~ "$line\n" if $line.chars < $width;
        my $pos = rindex $line, ' ', $width - 1;
        $out = $out ~ substr($line, 0, $pos) ~ "\n";
        $line = substr $line, $pos+1;
    }
    return $out;
}

my $in = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla.";

say wrap $in, $_ for 60, 35;
