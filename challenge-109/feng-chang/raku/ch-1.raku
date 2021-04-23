#!/bin/env raku
(1..20).map({ (2..^$^a).grep($^a%%*).sum }).put;
