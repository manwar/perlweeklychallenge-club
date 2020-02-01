# Square Secret Code
#
# The square secret code mechanism first removes any space from the original
# message. Then it lays down the message in a row of 8 columns. The coded
# message is then obtained by reading down the columns going left to right.
#
# For example, the message is “The quick brown fox jumps over the lazy dog”.
#
# Then the message would be laid out as below:
#
#   thequick
#   brownfox
#   jumpsove
#   rthelazy
#   dog
#
# The code message would be as below:
#
#   tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#
# Write a script that accepts a message from command line and prints the
# equivalent coded message.

sub encode($str) {
    # Lowercase all letters and remove white spaces.
    my $stripped = $str.lc.subst(/\s/, '', :g);

    # Extend string to multiple of 8 and rotate around 8.
    my @r = ($stripped ~ " " x (8 - $stripped.chars % 8)).comb.rotor(8, :partial);

    # Take Cartesian product of the rotated string.
    return ([Z~] @r).map({ $_.trim }).join(' ');
}

say encode("The quick brown fox jumps over the lazy dog");
