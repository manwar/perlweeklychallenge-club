#!/bin/sh

perl -MMath::Round=nearest -E '$r=nearest(0.001,shift()**(1/3));say $r==sprintf("%d",$r)?"true":"false"' "$@"