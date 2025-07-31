use 5.040;

use utf8::all; # utf8 @ARGV

# replacement for the pre-perl5.28 stringwise xor that worked on any codepoints (up to uvsize)
sub bitwise_xor {
    # copy/stringize arguments so overload/magic only happens once per arg
    my $a = "$_[0]";
    my $b = "$_[1]";
    if (!utf8::is_utf8($a) && !utf8::is_utf8($b)) {
        no if $] > 5.022, 'feature' => 'bitwise';
        return $a ^ $b;
    }
    if (length $a < length $b) {
        $a =~ s/./chr(ord $& ^ ord($b =~ m!.!gs && $&))/gse;
        return $a . substr $b, length $a;
    }
    else {
        $b =~ s/./chr(ord $& ^ ord($a =~ m!.!gs && $&))/gse;
        return $b . substr $a, length $b;
    }
}

sub buddy_strings($string1, $string2) {
    if ($string1 eq $string2) {
        # a doubled character to "swap"
        return $string1 =~ /(.)\1/s;
    }
    else {
        return
            # lengths must match
            length $string1 == length $string2
            # exactly 2 differing characters, adjacent
            && bitwise_xor($string1, $string2) =~ /^\0*([^\0])\1\0*\z/
            # in opposite order in the two strings
            && substr($string1, $-[1], 2) eq reverse substr($string2, $-[1], 2)
    }
}

sub main() {
    my @inputs = @ARGV;
    for my ($string1, $string2) (@inputs) {
        printf "%-30s\n%-30s\n    -> %s\n", $string1, $string2, (buddy_strings($string1, $string2) ? 'yes' : 'no');
    }
}

main() unless caller;
