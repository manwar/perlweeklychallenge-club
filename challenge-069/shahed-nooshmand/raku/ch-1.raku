($A ^..^ $B).grep: { /^ <[01689]>+ $/ and $_ eq .flip.trans(“69” => “96”) }
