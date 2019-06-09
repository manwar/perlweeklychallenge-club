use strict;
use warnings;
use POSIX;
 

 

#Write a script that computes the equal point in the Fahrenheit and Celsius scales
#knowing that the freezing point of water is 32 °F and 0 °C,
#and that the boiling point of water is 212 °F and 100 °C.
#This challenge was proposed by Laurent Rosenfeld

 
my $pointCelsius = 0;
my $equalPoint = 0;
my $keepSearching = 1;

while ($keepSearching){      

	my $pointFahrenheid= celsiusToFarenheit($pointCelsius) ;

	my $difference = $pointCelsius - $pointFahrenheid;  

	if ($difference  > 0 ){

		$pointCelsius -=  int( $difference/2) ? int( $difference/2) : ceil( $difference/2)  ;

	} elsif ($difference < 0 ){

		$pointCelsius +=  int( $difference/2) ? int( $difference/2) : floor($difference/2) ;

	} else {

		$equalPoint = $pointCelsius;

		$keepSearching = 0;
	}
}
 

print "Equal Point is $equalPoint\n";

 

sub fahrenheitToCelsius {

	my $degreesFarenheit = shift;

	my $degreesCelsius = ($degreesFarenheit - 32) * 5 / 9;

	return $degreesCelsius;      

}

 

sub celsiusToFarenheit {

	my $degreesCelsius = shift;

	my $degreesFarenheit = $degreesCelsius  *  9 / 5  + 32;

	return $degreesFarenheit;      

}