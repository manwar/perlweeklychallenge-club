use v6;

my %nums = 0 => '-', 1 => <_ , @>, 2 => <A B C>, 3 => <D E F>,
           4 => <G H I>, 5 => <J K L>, 6 => <M N O>,
           7 => <A Q R S>, 8 => <T U V>, 9 => <W X Y Z>;

my $str = @*ARGS[0] // "35";
take-one("", $str.comb);
say "";

sub take-one (Str $str, @digits is copy) {
    if @digits.elems == 0 {
        print "$str ";
        return;
    }
    my $digit = shift @digits;
    for %nums{$digit}.Seq -> $letter {
        my $new-str = $str ~ $letter;
        take-one($new-str, @digits)
    }
}
