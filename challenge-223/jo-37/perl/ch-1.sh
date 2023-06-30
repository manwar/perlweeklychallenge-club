#!/bin/sh
perl -MMath::Prime::Util=:all -E 'say prime_count shift' $1
