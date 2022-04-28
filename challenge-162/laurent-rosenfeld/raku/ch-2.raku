my (@c2l, %l2c);   # coordinates to letter, letter to coordinates

sub make-cipher-table (Str $in) {
    @c2l = ();
    %l2c = ();
    my $key = $in.lc;
    $key ~~ s:g/j/i/; # we can handle 25 letters, replace J's with I's
    $key ~~ s:g/\W//; # remove non alphanumecicals chars
    my @chars = ($key.comb, 'a'..'i', 'k'..'z').flat;
    my $i = 0;
    for @chars -> $let {
        next if %l2c{$let}:exists;
        my $row = $i div 5;
        my $col = $i % 5;
        $i++;
        %l2c{$let} = $row, $col;
        @c2l[$row][$col] = $let;
    }
}

sub encrypt ($in) {
    my $msg = $in.lc;
    $msg ~~ s:g/j/i/;
    $msg ~~ s:g/\W//; # remove non alphanumecicals chars
    $msg ~~ s:g/(.)$0/$0x$0/;  # adding 'x' between two identical letters
    $msg ~= "x" if $msg.chars % 2;  # padding
    return convert(1, $msg);
}

sub decrypt ($in) {
  return convert(-1, $in);
}

sub convert (Int $d, Str $msg) {
    # $d (direction) = 1 for encrypting and -1 for decrypting
    my $out = "";
    my $second;
    for $msg.comb -> $first, $second {
        my ($row1, $row2) = %l2c{$first}[0], %l2c{$second}[0];
        my ($col1, $col2) = %l2c{$first}[1], %l2c{$second}[1];
        if $row1 == $row2 {                     # same row
            $out ~= (@c2l[$row1][($col1 + $d)%5]) ~
                    (@c2l[$row2][($col2 + $d)%5]);
        } elsif $col1 == $col2 {                # same column
            $out ~= (@c2l[($row1 + $d) %5][$col1]) ~
                    (@c2l[($row2 + $d) %5][$col2]);
        } else {                                # rectangle
            $out ~= (@c2l[$row1][$col2]) ~
                    (@c2l[$row2][$col1]);
        }
    }
    return $out;
}

make-cipher-table("playfair example");
my $msg = "hide the gold in the tree stump";
my $crypted = encrypt($msg);
say "$msg -> $crypted";
say "Round trip: ", decrypt $crypted;

make-cipher-table("perl and raku");
$msg = "siderwrdulfipaarkcrw";
my $decrypted = decrypt $msg;
say "$msg -> $decrypted";
