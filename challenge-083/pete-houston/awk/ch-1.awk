#!/bin/gawk -f
{ x = 0; for (i = 2; i < NF; i++) { x += length ($i) }; print x }
