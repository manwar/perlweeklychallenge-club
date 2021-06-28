#include <utility>
#include <list>
#include <array>
#include <vector>
#include <map>
#include <iostream>

//compute the fields the knights can reach from a given position
std::vector<std::pair<int, int>> findTargetFields( const std::pair<int, int>
      & p ) {
  std::pair<int, int> neighbour( p ) ;
  std::vector<std::pair<int , int>> neighbours ;
  static std::array<int , 8> xmoves {2 , 1 , 1 , -2 , -1 , 2 , -1 , -2 } ;
  static std::array<int , 8> ymoves { 1 , 2 , -2 , 1 , 2 , -1 , -2 , -1 } ;
  for ( int i = 0 ; i < 8 ; i++ ) {
      neighbour.first += xmoves[ i ] ;
      neighbour.second += ymoves[ i ] ;
      neighbours.push_back( neighbour ) ;
      neighbour = p ;//put back to start
  }
  return neighbours ;
}

//is the position on board
bool isValid( const std::pair<int, int> & cell ) {
  return ( cell.first > 0 && cell.first < 9 && cell.second > 0 &&
    cell.second < 9 ) ;
}

//move from one point to the next
//we store all valid points on the board in allPoints and keep popping values
//from the front until we have the target point
//for every point, we have a given path which we store in a map with the point
//as key.
//Before we pop a value from the top of allPoints, we take the front point as
//the new currentPoint and the corresponding path for this point as the new path
std::list<std::pair<int , int>> moveFromPointToPoint( const std::pair<int, int>
      & startPoint , const std::pair<int, int> & targetPoint ) {
  std::list<std::pair<int , int>> path ;
  path.push_back( startPoint ) ;
  std::pair<int , int> currentPoint( startPoint ) ;
  std::map<std::pair<int , int> , std::list<std::pair<int, int>>> pathsForPoints ;
  pathsForPoints[ startPoint ] = path ;
  std::list<std::pair<int , int>> allPoints { startPoint } ;
  std::array<std::array<bool , 8> , 8> visited ;
  std::array<bool , 8> row ;
  row.fill( false ) ;
  visited.fill( row ) ;
  visited[startPoint.first - 1][startPoint.second - 1] = true ;
  while ( currentPoint != targetPoint ) {
      allPoints.pop_front( ) ;
      std::vector<std::pair<int , int>> targetFields = findTargetFields(
        currentPoint ) ;
      for ( auto & p : targetFields ) {
    if ( isValid( p ) && ! visited[p.first - 1][p.second - 1] ) {
        allPoints.push_back( p ) ;
        path.push_back( p ) ;
        pathsForPoints[ p ] = path ;
        visited[ p.first -1][p.second - 1] = true ;
        path = pathsForPoints[ currentPoint ] ;//return to the path for
                                              //currentPoint !
    }
      }
      currentPoint = allPoints.front( ) ;
      path = pathsForPoints[ currentPoint ] ;
  }
  return pathsForPoints[ currentPoint ] ;
}

int main( ) {
  std::vector<std::pair<int , int>> treasures { {6 , 5} , {4 , 3 } , {3 , 2 } ,
      {2 , 1 } , {2 , 2 } , {1 , 2 }} ;
  std::pair<int , int> knightPos { 8 , 1 } ;
  std::list<std::pair<int , int>> totalPath = moveFromPointToPoint( knightPos ,
    *(treasures.begin( ) ) ) ;
  int len = treasures.size( ) ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::list<std::pair<int, int>> path = moveFromPointToPoint(
        *(treasures.begin( ) + i ) , *(treasures.begin( ) + i + 1 )) ;
      path.pop_front( ) ; //the starting point was the end point of previous move!
      for ( auto & p : path ) {
    totalPath.push_back( p ) ;
      }
  }
  for ( auto & p : totalPath ) {
      std::cout << '(' << p.first << ',' << p.second << ')' ;
      if ( p != totalPath.back( ) )
    std::cout << "->" ;
      else
    std::cout << std::endl ;
  }
  return 0 ;
}
