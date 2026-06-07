#!/usr/bin/env python3 
def make_chessboard():
   chessboard = []
   for i in range( 1, 9 ):
      if i % 2 == 1:
         chessboard.append( "BW" * 4 )
      else:
         chessboard.append( "WB" * 4 )
   return chessboard

line = input( "Enter two chessfields separated by blanks!\n" ) 
fields = line.split( ' ' )
chessboard = make_chessboard( )
fr = int( fields[0][1:2] )
sr = int( fields[1][1:2] )
fc = "abcdefgh".find( fields[0][0:1] )
sc = "abcdefgh".find( fields[1][0:1] )
print( chessboard[fr - 1][fc:fc + 1] == chessboard[sr - 1][sc:sc + 1] )   
