import algorithm

proc check_squares (p: array[0..6, int]) : bool =
    var sum = p[0] + p[1]
    return ( p[1] + p[2] + p[3] == sum and
      p[3] + p[4] + p[5] == sum and p[5] + p[6] == sum )


var input = [1, 2, 3, 4, 5, 6, 7] # List has to start sorted
while input.nextPermutation():
  if check_squares(input):
    echo input
