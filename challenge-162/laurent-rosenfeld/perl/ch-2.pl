use strict;
use warnings;
use feature "say";

sub make_cipher_table {
    my $key = lc $_[0];
    $key =~ s/j/i/g; # we can handle 25 letters, replace J's with I's
    $key =~ s/\W//g; # remove non alphanumecicals chars
    my @chars = ((split //, $key), 'a'..'i', 'k'..'z');
    my $i = 0;
    my (@c2l, %l2c);   # coordinates to letter, letter to coordinates
    for my $let (@chars) {
        next if exists $l2c{$let};
        my $row = int $i / 5;
        my $col = $i % 5;
        $i++;
        $l2c{$let} = [$row, $col];
        $c2l[$row][$col] = $let;
    }
    return \@c2l, \%l2c
}

sub encrypt {
    my $msg = lc $_[0];
    $msg =~ s/j/i/g;
    $msg =~ s/\W//g; # remove non alphanumecicals chars
    $msg =~ s/(.)\1/$1x$1/;  # adding 'x' between two identical letters
    $msg =~ "x" if length($msg) % 2;  # padding
    return convert(1, $msg);
}

sub decrypt {
  return convert(-1, $_[0]);
}

my ($c, $l) = make_cipher_table("playfair example");
my @c2l = @$c;
my %l2c = %$l;
my $msg = "hide the gold in the tree stump";
my $crypted = encrypt($msg);
say "$msg -> $crypted";
say "Round trip: ", decrypt $crypted;
($c, $l) = make_cipher_table("perl and raku");
@c2l = @$c;
%l2c = %$l;
$msg = "siderwrdulfipaarkcrw";
my $decrypted = decrypt $msg;
say "$msg -> $decrypted";

sub convert {
    my ($d, $msg) = @_;
    # $d (direction) = 1 for encrypting and -1 for decrypting
    my $out = "";
    my @letters = split //, $msg;
    while (@letters) {
        my ($first, $second) = splice @letters, 0, 2;
        # my ($row1, $row2) = (%l2c{$first}[0], %l2c{$second}[0]);
        # my ($col1, $col2) = (%l2c{$first}[1], %l2c{$second}[1]);
        if ($l2c{$first}[0] == $l2c{$second}[0]) {           # same row
            $out .= ($c2l[$l2c{$first }[0]][($l2c{$first }[1] + $d)%5]) .
                    ($c2l[$l2c{$second}[0]][($l2c{$second}[1] + $d)%5]);
        } elsif ($l2c{$first}[1] == $l2c{$second}[1]) {        # same column
            $out .= ($c2l[($l2c{$first }[0] + $d) %5][$l2c{$first}[1]]) .
                    ($c2l[($l2c{$second}[0] + $d) %5][$l2c{$second}[1]]);
        } else {                                             # rectangle
            $out .= ($c2l[$l2c{$first }[0]][$l2c{$second}[1]]) .
                    ($c2l[$l2c{$second}[0]][$l2c{$first }[1]]);
        }
    }
    return $out;
}
