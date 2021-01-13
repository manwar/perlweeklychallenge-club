raku -e 'lines>>.split("@").unique(as=>{.[0] ~ .[1].lc}).sort({.[1].lc ~ .[0]})>>.join("@")>>.say' mails.txt
