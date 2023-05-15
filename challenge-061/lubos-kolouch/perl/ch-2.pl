use strict;
use warnings;

sub is_valid_octet {
    my $s = shift;
    return 0 <= $s && $s <= 255 && $s == int($s);
}

sub restore_ip_addresses {
    my $s = shift;
    my @result;
    my $n = length($s);

    for my $i (1 .. 3) {
        for my $j ($i + 1 .. $i + 3) {
            for my $k ($j + 1 .. $j + 3) {
                if ($k < $n) {
                    my $s1 = substr($s, 0, $i);
                    my $s2 = substr($s, $i, $j - $i);
                    my $s3 = substr($s, $j, $k - $j);
                    my $s4 = substr($s, $k);
                    if (is_valid_octet($s1) && is_valid_octet($s2) && is_valid_octet($s3) && is_valid_octet($s4)) {
                        push @result, "$s1.$s2.$s3.$s4";
                    }
                }
            }
        }
    }
    return @result;
}

my $input_str = "25525511135";
my @ipv4_addresses = restore_ip_addresses($input_str);
for my $address (@ipv4_addresses) {
    print "$address\n";
}

