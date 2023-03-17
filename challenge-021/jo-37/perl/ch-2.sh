#!/bin/sh
perl -MURI -E 'say URI->new(shift)->canonical' "$1"
