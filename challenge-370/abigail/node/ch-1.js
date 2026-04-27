#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Split input into paragraph and banned_str
    //
    var [paragraph, banned_str] = line . split ("//")

    //
    // Extract the banned words, put them in an object
    //
    var banned = {}
    banned_str . toLowerCase () . matchAll (/[a-z]+/g) . forEach ((match) => {
        var ban = match [0]
        banned [ban] = 1
    })

    //
    // Lower case the paragraph, and extract its words. If it is not
    // banned, count its frequency in the ok object
    //
    var max = ""
    var ok = {} 
    ok [max] = 0
    paragraph . toLowerCase () . matchAll (/[a-z]+/g) . forEach ((match) => {
        var word = match [0]
        if (!banned [word]) {
            ok [word] ||= 0
            ok [word] ++
        }
    })

    //
    // Find the word which occurs most frequently
    //
    for (var word in ok) {
        if (ok [word] > ok [max]) {
            max = word
        }
    }

    console . log (max)

    
 
})
