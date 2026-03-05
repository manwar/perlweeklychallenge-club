#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>
#include <cctype>

bool isValidAddress( const std::vector<std::string> & addressparts ) {
   return addressparts.size( ) == 4 && std::all_of( addressparts.begin( ) , 
         addressparts.end( ) , []( const auto s ) { return std::all_of( s.begin( ), 
            s.end( ), [](char c){ return std::isdigit( c ) ; } ); } ) &&
         std::all_of( addressparts.begin( ) , 
            addressparts.end( ) , []( const auto s ) { return std::stoi( s ) >= 0 && 
            std::stoi( s ) <= 255 ; } ) ;
}

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

std::string to_octets( int number ) {
   std::string binary ;
   while ( number != 0 ) {
      if ( number % 2 == 1 ) 
         binary.push_back( '1' ) ;
      else
         binary.push_back( '0' ) ;
      number /= 2 ;
   }
   std::reverse( binary.begin( ) , binary.end( ) ) ;
   std::string padded {""} ;
   padded.append( 8 - static_cast<int>(binary.length( ) ) , '0' ) ;
   padded += binary ;
   return padded ;
}

int main( ) {
   std::cout << "Enter an IPv4 address!\n" ;
   std::string ipv4 ;
   std::cin >> ipv4 ;
   std::cout << "Enter a network address in CIDR format!\n" ;
   std::string cidr ;
   std::cin >> cidr ;
   auto addressparts { split( ipv4 , '.' ) } ;
   auto networkparts { split( cidr , '/' ) } ;
   auto netaddressparts { split( networkparts[0] , '.' ) } ;
   bool result = false ;
   if ( isValidAddress( addressparts ) && isValidAddress( netaddressparts ) ) {
      if ( std::all_of( networkparts[1].begin( ) , networkparts[1].end( ) , []
               (char c) { return std::isdigit( c ) ; } ) ) {
         int networkrange = std::stoi( networkparts[1] ) ;
         if ( networkrange >= 0 && networkrange <= 32 ) {
            std::string allAddressOctets {""} ;
            std::string allNetworkOctets {""} ;
            for ( auto part : addressparts ) {
               int num = std::stoi( part ) ;
               allAddressOctets += to_octets( num ) ;
            }
            for ( auto part : netaddressparts ) {
               int num = std::stoi( part ) ;
               allNetworkOctets += to_octets( num ) ;
            }
            result = ( allAddressOctets.substr( 0 , networkrange ) == 
                  allNetworkOctets.substr( 0 , networkrange ) ) ;
         }
      }
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}
