#include <iostream>
#include <vector>

int main( ) {
  std::cout << "Please enter an array, number by number( negative number " ;
  std::cout << "to end!)\n" ;
  int num ;
  std::vector<int> nums1 ;
  std::vector<int> nums2 ;
  std::cin >> num ;
  while ( num > 0 ) {
      nums1.push_back( num ) ;
      std::cin >> num ;
  }
  std::cout << "Enter second array, as many numbers as in first array!\n" ;
  std::cin >> num ;
  while ( num > 0 ) {
      nums2.push_back( num ) ;
      std::cin >> num ;
  }
  while ( nums2.size( ) != nums1.size( ) ) {
      nums2.clear( ) ;
      std::cout << "second array should have as many numbers as the first array!\n" ;
      std::cin >> num ;
      while ( num > 0 ) {
    nums2.push_back( num ) ;
    std::cin >> num ;
      }
  }
  int sum = 0 ;
  for ( int i = 0 ; i < nums1.size( ) ; i++ )
      sum += nums1[ i ] * nums2[ i ] ;
  std::cout << sum << std::endl ;
  return 0 ;
}
