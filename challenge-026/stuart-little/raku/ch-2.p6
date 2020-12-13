#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated list of angles in degrees>

say atan2(|(&sin,&cos).map( -> &f { @*ARGS.map((*.EVAL * pi / 180).&f).sum })) * 180 / pi
