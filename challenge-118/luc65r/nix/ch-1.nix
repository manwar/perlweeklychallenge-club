#!/usr/bin/env -S nix eval --raw --impure -f

with builtins;

let
  num = let
    env = getEnv "num";
  in
    if env != ""
    then fromJSON env
    else abort "please set the environment variable `num`";

  /* Returns the remainder of the euclidian division of `a` and `b`.

     Type: rem :: int -> int -> int
  */
  rem = a: b: a - (a / b) * b;

  /* Decomposes `n` into a list of digits in base `base`.

     Type: toBase :: int -> int -> [int]
  */
  toBase = base: n: let
    q = n / base;
    r = rem n base;
  in
    if r == n
    then [r]
    else toBase base q ++ [r];

  /* Reverses the list.

     Type: rev :: [a] -> [a]
  */
  rev = foldl' (x: y: [y] ++ x) [];

  numBase2 = toBase 2 num;
  
in "${toString (if numBase2 == rev numBase2 then 1 else 0)}\n"
