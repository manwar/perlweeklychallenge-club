#!/bin/sh

perl -MTime::Piece -E'say Time::Piece->strptime(shift,"%Y-%m-%d")->yday+1' "$@"
