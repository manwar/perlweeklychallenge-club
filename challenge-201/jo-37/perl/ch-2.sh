#!/bin/sh

# Find the number of partitions
perl -MMath::Prime::Util=:all -E 'say partitions shift' $1
