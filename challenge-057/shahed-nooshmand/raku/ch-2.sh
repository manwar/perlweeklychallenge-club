raku -e 'say (my @words = get.words).map: { m« ^.+? <?{1 == @words.grep: *.starts-with: ~$/}> » ?? ~$/ !! Nil }'
