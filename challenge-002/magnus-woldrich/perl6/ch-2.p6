#!/bin/perl6
# my first ever perl6 script
# 10/10 would do again

if @*ARGS {
  for @*ARGS -> $arg {
    printf "%d\n", $arg;
  }
}
else {
  printf "%d\n", $_ for lines();
}
