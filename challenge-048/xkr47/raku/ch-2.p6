#!/usr/bin/env perl6

(2000...2999)
        .map({
            try {
                    Date.new(($_, $_.flip.match(/^(..)(..)/).map(*.Str)).flat.join("-"))
            }
        })
        .grep(*.defined)
        .map({ sprintf "%02d%02d%04d", .month, .day, .year })
        .say
