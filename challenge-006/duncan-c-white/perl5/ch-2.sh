#!/bin/sh -
perl -Mbigrat=bexp,bpi -e 'print bexp(bpi(32)*sqrt(163),32)."\n"'
