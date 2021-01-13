use strict;
use warnings;


my @aListIntegers = ();
for (0..int(rand(10)+3)){
    my $number = int(rand(50))+1;
    push (@aListIntegers , $number );
}

my @aNobleIntegers = findNobleIntegers(@aListIntegers);

print "List: ".join(',', @aListIntegers)."\n";
print "Noble Integers: ".join(',', @aNobleIntegers)."\n";

sub findNobleIntegers {
    my @aIntegers = @_;
    my @aNoble = ();
    foreach my $integer (@aIntegers){
       my $countGreater = 0;
       foreach my $integerToCompare (@aIntegers){
            if ( $integerToCompare > $integer ){
                $countGreater++;
            }        
       }
       if ($integer == $countGreater){
            push (@aNoble , $integer) ;
       } 
    }
    return @aNoble ;
}
