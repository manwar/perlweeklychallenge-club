use strict;
use warnings;
## 
# Write a script to validate a given bitcoin address.
## 
use boolean; 
use Digest::SHA q/sha256/;

my @BASE58 = (1 .. 9, 'A' .. 'H', 'J' .. 'N', 'P' .. 'Z', 'a' .. 'k', 'm' .. 'z');
my %BASE58_ENCODING = map { $BASE58[$_] => $_ } 0 .. 57; 

sub base58_decode{
    my($address) = @_;  
    my @bytes;
    my @characters = map { $BASE58_ENCODING{$_} } split(//, $address);
    foreach my $c (@characters) {
        for (my $i = 25; $i--; ) {
            $c += (58 * ($bytes[$i] || 0));
            $bytes[$i] = $c % 256;
            $c /= 256;
        }
    }
    return @bytes;
}
 
sub validate_address {
    my($address) = @_;  
    my @address_bytes = base58_decode($address);
    if((pack "C*", @address_bytes[21..24]) eq substr(sha256(sha256(pack("C*", @address_bytes[0..20]))), 0, 4)){
        return true;
    } 
    return false;
}

##
# Main
## 
my $address = $ARGV[0];  
if(validate_address($address)){    
    print "$address is VALID\n";
}  
else{
    print "$address is INVALID\n";
}   
