#!/bin/sh
perl -MMath::Prime::Util=factor -E 'say "@{[factor shift]}"' $1
