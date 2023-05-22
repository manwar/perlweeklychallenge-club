#!/usr/bin/env raku
@*ARGS.sort({"$^b$^a".Int <=> "$^a$^b".Int}).join('').put;
