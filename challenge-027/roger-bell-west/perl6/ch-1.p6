#! /usr/bin/perl6

my @x;
my @y;

@x[1]=shift @*ARGS;
@y[1]=shift @*ARGS;
@x[2]=shift @*ARGS;
@y[2]=shift @*ARGS;
@x[3]=shift @*ARGS;
@y[3]=shift @*ARGS;
@x[4]=shift @*ARGS;
@y[4]=shift @*ARGS;

my $d=(@x[1]-@x[2])*(@y[3]-@y[4]) - (@y[1]-@y[2])*(@x[3]-@x[4]);
if ($d==0) {
  die "Lines are parallel or coincident.\n";
}
my $t=( (@x[1]-@x[3])*(@y[3]-@y[4]) - (@y[1]-@y[3])*(@x[3]-@x[4]) )/$d;
if $t < 0 or $t > 1 {
  die "No intersection.\n";
}
my $u=( (@y[1]-@y[2])*(@x[1]-@x[3]) -  (@x[1]-@x[2])*(@y[1]-@y[3]))/$d;
if $u < 0 or $u > 1 {
  die "No intersection.\n";
}
@x[0]=@x[1]+$t*(@x[2]-@x[1]);
@y[0]=@y[1]+$t*(@y[2]-@y[1]);
say "@x[0] @y[0]";
