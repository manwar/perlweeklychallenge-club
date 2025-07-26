#!/usr/bin/env -S perl -p
s/\d+/sprintf"%b",$&/eg
