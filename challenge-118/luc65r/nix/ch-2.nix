#!/usr/bin/env -S nix eval --raw --impure -f

/* That wasn't easy!
   I think it outputs the fastest path, and it's pretty fast;
   it takes less than 0.4s to output the solution for 6 treasures.
   The code isn't pretty, but considering the Nix expression language
   is a DSL, I think I did fairly well.

   I made the assumption that to find the fastest path to a square,
   the knight can go directly towards that square if he is far enough
   from that square (at least 5 units).
   This reducts considerably the number of paths to explore during
   the depth-first search.
*/

with builtins;

let
  treasures = let
    env = getEnv "treasures";
  in
    if match "^[a-h][1-8](:[a-h][1-8])*$" env != null
    then map stringToSquare (filter isString (split ":" env))
    else abort ''
      please set the environment variable `treasures`.
      example: treasures=e6:c4:b3:b2:a2:b1
    '';

  startingPosition = stringToSquare "a8";

  alphabet = [ "a" "b" "c" "d" "e" "f" "g" "h" ];

  letters = listToAttrs (genList (i: {
    name = elemAt alphabet i;
    value = i + 1;
  }) 8);

  stringToSquare = str: let
    m = match "^([a-h])([1-8])$" str;
  in if m == null then null else {
    y = fromJSON (elemAt m 1);
    x = letters.${elemAt m 0};
  };

  squareToString = sq:
    elemAt alphabet (sq.x - 1) + toString sq.y;

  /*
     Type: squarePair :: square -> square -> string
  */
  squarePair = a: b: squareToString a + squareToString b;

  /*
     Type: validSquare :: square -> bool
  */
  validSquare = { y, x }:
    1 <= y && y <= 8 && 1 <= x && x <= 8;

  /*
     Type: knightMoves :: square -> [square]
  */
  knightMoves = { y, x }:
    filter validSquare [
      # TODO: generate this
      { y = y + 2; x = x + 1; }
      { y = y + 2; x = x - 1; }
      { y = y - 2; x = x + 1; }
      { y = y - 2; x = x - 1; }
      { y = y + 1; x = x + 2; }
      { y = y + 1; x = x - 2; }
      { y = y - 1; x = x + 2; }
      { y = y - 1; x = x - 2; }
    ];

  /*
     Type: squareEq :: square -> square -> bool
  */
  squareEq = a: b: a.x == b.x && a.y == b.y;

  /*
     Type: abs :: int -> int
  */
  abs = n:
    if n < 0 then -n else n;

  /* Returns the shortest sublist.

     Type: shortest :: [[a]] -> [a]
  */
  shortest = list: foldl'
    (a: b: if length a < length b then a else b)
    (head list) list;

  /* Returns the last element of a list.

     Type: last :: [a] -> a
  */
  last = list: elemAt list (length list - 1);

  /* Reverses the list (strict).

     Type: rev :: [a] -> [a]
  */
  rev = foldl' (x: y: [y] ++ x) [];

  /* Generates all permutations of the list.

     Type: permutations :: [a] -> [[a]]
  */
  permutations = list: let
    /*
       Type: interleave :: a -> [a] -> [[a]]
    */
    interleave = x: list:
      genList
        (j: genList
          (i: if i == j
              then x
              else elemAt list (if i > j
                                then i - 1
                                else i))
          (length list + 1))
        (length list + 1);
  in if length list == 1
     then [list]
     else concatMap (interleave (head list)) (permutations (tail list));

  /* Generate all in-order pairs.

     Type: pairs :: [a] -> [{ fst :: a, snd :: b }]
  */
  pairs = list:
    if length list < 2
    then []
    else genList (x: {
      fst = head list;
      snd = elemAt list (x + 1);
    }) (length list - 1) ++ pairs (tail list);

  /* Find the shortest path from a square to another.

     Type: moveTo :: square -> square -> [square] | null
  */
  moveTo = start: to: let
    /*
       Type: close :: square -> square -> bool
    */
    close = a: b:
      abs (a.x - b.x) < 5 && abs (a.y - b.y) < 5;

    /*
       Type: dfs :: square -> square -> int -> [squares] | null
    */
    dfs = start: to: depth: let # TODO: filter out last position
      moves = filter (close to) (knightMoves start);
      paths = filter (x: x != null)
        (map (m: dfs m to (depth - 1)) moves);
      fastestPath = shortest paths;
    in
      if squareEq start to
      then [start]
      else
        if depth == 0
        then null
        else
          if paths != []
          then [start] ++ fastestPath
          else null;
  in
    if close start to
    then dfs start to 5
    else let
      xDiff = to.x - start.x;
      yDiff = to.y - start.y;
      xDir = if xDiff < 0 then -1 else 1;
      yDir = if yDiff < 0 then -1 else 1;
      s = if abs xDiff > abs yDiff
          then { y = start.y + yDir; x = start.x + 2 * xDir; }
          else { y = start.y + 2 * yDir; x = start.x + xDir; };
    in [start] ++ moveTo s to;

  /* All the paths between the treasures and the starting position.
     Indexed by `squarePair`.
  */
  paths = listToAttrs (concatMap
    ({ fst, snd }: let
      p = moveTo fst snd;
    in [
      {
        name = squarePair fst snd;
        value = p;
      }
      {
        name = squarePair snd fst;
        value = rev p;
      }
    ])
    (pairs ([startingPosition] ++ treasures)));

  /* Completes the path starting from the starting position
     and passing by every square in order.

     Type: completePath = [square] -> [square]
  */
  completePath = squares: foldl'
    (a: b: a ++ tail paths.${squarePair (last a) b})
    [startingPosition] squares;

  allPossiblePaths = map completePath (permutations treasures);

in "${toString (map squareToString (shortest allPossiblePaths))}\n"
