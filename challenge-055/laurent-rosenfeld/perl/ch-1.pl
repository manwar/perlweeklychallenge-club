use strict;
use warnings;
use feature "say";

sub flip {
    my $bin_nr = shift;
    die "Please supply a binary string."
        unless $bin_nr =~ /^[01]*$/;
    my @chars = split //, $bin_nr;
    my @result;
    for my $left (0..$#chars) {
        for my $right ($left..$#chars) {
            my @tmp_chars = @chars;
            for my $i ($left..$right) {
                $tmp_chars[$i] = $chars[$i] ? 0 : 1;
            }
            my $count = scalar grep $_ == 1, @tmp_chars;
            $result[$count] .= "$left-$right: @tmp_chars\n";
        }
    }
    return $result[-1];
}
say flip shift // "01011" ;
