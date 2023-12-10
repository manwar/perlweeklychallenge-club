#!/usr/bin/env julia

using Random: shuffle

[println(x) for x in shuffle(1:49)[1:6]]
