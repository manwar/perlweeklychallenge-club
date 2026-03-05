use v6 ;

#the net is full of regexes for IPv4 addresses , they could very much become
#part of the problem...
sub isValidAddress( @address ) {
   if @address.elems == 4 && @address.grep( {$_ ~~ /^\d+$/} ).elems == 4 {
      my @parts = @address.map( { .Int } ) ;
      return @parts.grep( { $_ >= 0 && $_ <= 255 } ).elems == 4 ;
   }
   else {
      return False ;
   }
}

sub to_octet( $number ) {
   my $binary = $number.base( 2 ) ;
   my $result = '0' x ( 8 - $binary.chars ) ;
   $result ~= $binary ;
   return $result ;
}

say "Enter an IPv4 address!" ;
my $addr = $*IN.get ;
say "Enter an IPv4 network in CIDR form!" ;
my $network = $*IN.get ;
my @addressparts = $addr.split( /\./ ) ;
my @networkparts = $network.split( /\// ) ;
my $result = False ;
if ( isValidAddress( @addressparts ) && isValidAddress( @networkparts[0].
         split(/\./ )) ) {
   if ( @networkparts[1] ~~ /^\d+$/ ) {
      my $number = @networkparts[1].Int ;
      if ( $number >= 0 && $number <= 32 ) {
         my $address_totalBinary ;#32 bytes of IPv4 address
         my $network_totalBinary ;#32 bytes of network address
         for @addressparts -> $part {
            my $num = $part.Int ;
            $address_totalBinary ~= to_octet( $num ) ;
         }
         my @networkp = @networkparts[0].split( /\./ ) ;
         for @networkp -> $part {
            my $num = $part.Int ;
            $network_totalBinary ~= to_octet( $num ) ;
         }
         $result = ( $address_totalBinary.substr( 0 , $number ) eq 
               $network_totalBinary.substr( 0 , $number ) ) ;
      }
   }
}
say $result ;


