#!/usr/bin/env perl

use v5.38;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Socket;

=head1 COMMENTS

 Task 2: Subnet Sheriff

 You are given an IPv4 address and an IPv4 network (in CIDR format).

 Write a script to determine whether both are valid and the address falls within
 the network. For more information see the Wikipedia article:
 https://en.wikipedia.org/wiki/IPv4 


=cut


my %examples = ( Example_1 => { ip_addr => "192.168.1.45",
                                domain  => "192.168.1.0/24",
                              },
		 Example_2 => { ip_addr => "10.0.0.256",
                                domain  => "10.0.0.0/24",
		              },
		 Example_3 => { ip_addr => "172.16.8.9",
                                domain  => "172.16.8.9/32",
		              },
		 Example_4 => { ip_addr => "172.16.4.5",
                                domain  => "172.16.0.0/14",
		              },
		 Example_5 => { ip_addr => "192.0.2.0",
                                domain  => "192.0.2.0/25",
		              },
               );

		 
foreach my $example ( sort keys %examples ) {
    my $output = q{};
    my $subnet_mask = q{};
    my @octets = split(/\./, $examples{$example}{ip_addr});
    # Apparently the only allowed valid numbers are between
    # 0 and 255, so we'll test for that first.
    if ( grep { $_ > 255 } @octets ) {
	$output = 'false';
    }
    else {
	# If none of the octets exceed decimal 255 then we need to
	# convert the IP addresse and the network into their binary equivalents
	my $ip_addr = unpack('B32', inet_aton($examples{$example}{ip_addr}));
        my ( $domain, $suffix, ) = split(/\//, $examples{$example}{domain});
        $domain = unpack('B32', inet_aton($domain));

        # There is likely some slick way to do this that all the cool kids
	# use, but I didn't even really grok why IP addresses are built up
        # in such a bizarro fashion until this particular Perl Weekly Challenge
	# so I derived this algorithm on the fly:
        my $subnet_mask = q{};	
        for my $bit ( 1..32 ) {
            if ( $bit > $suffix ) {
		$subnet_mask .= 0;
	    }
	    else {
		$subnet_mask .= 1;
	    }
	}

	# I assumed, naively, that having decoded the decimal version of the
	# octets into binary 1's and 0's that we were ready to use
	# Perl's version of the bitwise AND operator to mask the
	# bits in the IP address.  Not so.  Using bitwise AND on
	# the 1's and 0's did not yield output at all like what I
        # was expecting.
	# It turns out there is one more step; Perl interprets
	# my 1's and 0's as strings of characters, NOT binary
	# numbers, alas.  And thus we need to convert our 1's
	# and 0's which are a binary strings into binary integers
	# (are we having fun yet?):
	my $ip_int   = oct("0b" . $ip_addr);
        my $mask_int = oct("0b" . $subnet_mask);
        my $network_int = oct("0b" . $domain);

	# Finally starting with decimals, which we rendered as binary strings
	# we end up with binary integers, which we hope is what we want.
	# So that we can . . . 
        # Perform bitwise AND
        my $result_int = $ip_int & $mask_int;

        # Now we can compare the masked ip_addr to the network domain and see if
	# this ip_addr is actually contained in this network (the original task)
        if ($result_int == $network_int) {
            $output = 'true';
        }
        else {
            $output = 'false'
        }
    }

    print $example, "\n";
    print "Input: ip_addr = \"", $examples{$example}{ip_addr}, "\"\n";
    print "       domain  = \"", $examples{$example}{domain}, "\"\n";
    print "Output: $output\n\n";
}    

__END__

OUTPUT from running this Script:

Example_1
Input: ip_addr = "192.168.1.45"
       domain  = "192.168.1.0/24"
Output: true

Example_2
Input: ip_addr = "10.0.0.256"
       domain  = "10.0.0.0/24"
Output: false

Example_3
Input: ip_addr = "172.16.8.9"
       domain  = "172.16.8.9/32"
Output: true

Example_4
Input: ip_addr = "172.16.4.5"
       domain  = "172.16.0.0/14"
Output: true

Example_5
Input: ip_addr = "192.0.2.0"
       domain  = "192.0.2.0/25"
Output: true

