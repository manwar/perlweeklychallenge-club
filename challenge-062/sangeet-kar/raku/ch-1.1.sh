raku -e 'lines>>.split("@").sort({.[1].lc ~ .[0]})>>.join("@")>>.say' mails.txt mails2.txt
