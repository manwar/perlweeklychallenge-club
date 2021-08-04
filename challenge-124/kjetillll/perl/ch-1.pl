#!/usr/bin/env perl
print qx(curl -si https://theweeklychallenge.org/blog/perl-weekly-challenge-124/)=~m|<code>([\s^]+)</code>| ? $1 : ''
