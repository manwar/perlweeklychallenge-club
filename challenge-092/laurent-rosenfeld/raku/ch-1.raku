use v6;
my @tests = (< abc xyz >), (< abb xyy >), (< sum add >),
    (< ACAB XCXY >), (< abc uvwxy >);

    for @tests -> @strings {
        say "@strings[]: ", is-isomorphic @strings;
    }

sub is-isomorphic (@strings) {
    my ($str1, $str2) = @strings;
    return 0 if $str1.chars != $str2.chars;
    my %transcode;
    my SetHash $seen;
    for 0..$str1.chars - 1 -> $i {
        my $char1 = $str1.substr($i, 1);
        my $char2 = $str2.substr($i, 1);
        if %transcode{$char1}:exists {
            return 0 if %transcode{$char1} ne $char2;
        } else {
            return 0 if $seen{$char2};
            %transcode{$char1} = $char2;
            $seen{$char2}++;;
        }
    }
    return 1
}
