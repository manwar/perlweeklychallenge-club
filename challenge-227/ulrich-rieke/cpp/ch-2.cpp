#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <utility>
#include <cmath> 

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int roman_to_arabic( const std::string & numberstring , const 
      std::map<std::string, int> & numbertable ) {
   int len = numberstring.length( ) ;
   auto found = numbertable.find( numberstring ) ;
   if ( found != numbertable.end( ) ) {
      return found->second ;
   }
   else {
      int start = 0 ;
      int sum = 0 ;
      int howmany = 1 ;
      while ( start + howmany < len + 1 ) {
	 std::string partString ( numberstring.substr( start , howmany ) ) ;
	 if ( numbertable.find( partString ) != numbertable.end( ) ) 
	    howmany++ ;
	 else {
	    howmany-- ;
	    partString = numberstring.substr( start , howmany ) ;
	    found = numbertable.find( partString ) ;
	    sum += found->second ;
	    start = start + howmany ;
	    howmany = 1 ;
	 }
      }
      howmany-- ;
      std::string partString( numberstring.substr( start , howmany ) ) ;
      found = numbertable.find( partString ) ;
      sum += found->second ;
      return sum ;
   }
}

std::string arabToRoman( int number , const std::map<int , std::string> &
      arabRomanAssos ) {
   int num = 0 ;
   std::string romanNumber ;
   while ( number != 0 ) {
      if ( number > 1000 ) {
	 num = number / 1000 * 1000 ;
      }
      if ( number < 1000 && number >= 100 ) {
	 num = number / 100 * 100 ;
      }
      if ( number < 100 && number >= 10 ) {
	 num = number / 10 * 10 ;
      }
      if ( number < 10 ) {
	 num = number ;
      }
      std::string associated ;
      auto found = arabRomanAssos.find( num ) ;
      romanNumber += found->second ;
      number -= num ;
   }
   return romanNumber ;
}

int main( ) {
   std::map<std::string , int> romanToIntMap ;
   romanToIntMap.insert( {{"M" , 1000 } ,
	                  {"MM" , 2000 } , 
			  {"MMM" , 3000 } , 
			  {"C" , 100 } , 
			  {"CC" , 200 } , 
			  {"CCC" , 300 } ,
			  {"CD" , 400 } , 
			  {"D" , 500 } , 
			  {"DC" , 600 } , 
			  {"DCC" , 700 } , 
			  {"DCCC" , 800 } , 
			  {"CM" , 900 } ,
			  {"X" , 10 } ,
			  {"XX" , 20 } , 
			  {"XXX" , 30 } , 
			  {"XL" , 40 } , 
			  {"L" , 50 } , 
			  {"LX" , 60 } , 
			  {"LXX" , 70 } , 
			  {"LXXX" , 80 } , 
			  {"XC" , 90 } , 
			  {"I" , 1 } , 
			  {"II" , 2 } , 
			  {"III" , 3 } , 
			  {"IV" , 4 } , 
			  {"V" , 5 } , 
			  {"VI" , 6 } , 
			  {"VII" , 7 } , 
			  {"VIII" , 8 } , 
			  {"IX" , 9 } } ) ;
   std::map<int , std::string> intToRomanMap ;
   for ( auto & p : romanToIntMap ) {
      intToRomanMap.insert( std::make_pair( p.second , p.first ) ) ;
   }
   std::cout << "Enter a 2-term string in Roman numerals!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> allTerms ( split( line , " " ) ) ;
   std::string firstRoman ( allTerms[ 0 ] ) ;
   std::string secondRoman( allTerms[ 2 ] ) ;
   std::string oper ( allTerms[ 1 ] ) ;
   std::string result ;
   int firstTerm = roman_to_arabic( firstRoman, romanToIntMap ) ;
   int secondTerm = roman_to_arabic( secondRoman , romanToIntMap ) ;
   if ( oper == "+" ) {
      int sum = firstTerm + secondTerm ;
      if ( sum > 3999 ) {
	 result = "non potest" ;
      }
      else {
	 result = arabToRoman( sum , intToRomanMap ) ;
      }
   }
   if ( oper == "-" ) {
      int difference = firstTerm - secondTerm ;
      if ( difference < 0 ) {
	 result = "non potest" ;
      }
      if ( difference == 0 ) {
	 result = "nulla" ;
      }
      if ( difference > 0 ) {
	 result = arabToRoman( difference , intToRomanMap ) ;
      }
   }
   if ( oper == "*" ) {
      int product = firstTerm * secondTerm ;
      if ( product > 3999 ) {
	 result = "non potest" ;
      }
      else {
	 result = arabToRoman( product , intToRomanMap ) ;
      }
   }
   if ( oper == "/" ) {
      int quotient = firstTerm / secondTerm ;
      if ( secondTerm * quotient != firstTerm ) {
	 result = "non potest" ;
      }
      else {
	 result = arabToRoman( quotient , intToRomanMap ) ;
      }
   }
   if ( oper == "**" ) {
      int potence = static_cast<int>( std::pow( static_cast<double>( firstTerm ),
	       static_cast<double>( secondTerm ) )) ;
      if ( potence > 3999 ) {
	 result = "non potest" ;
      }
      else {
	 result = arabToRoman( potence , intToRomanMap ) ;
      }
   }
   std::cout << line << " = " << result << std::endl ;
   return 0 ;
}


