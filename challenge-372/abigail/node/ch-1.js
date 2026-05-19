#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Count spaces
    //
    let spaces  = [... line . matchAll (/ /g)] . length

    //
    // Remove quotes, and split into words. When splitting,
    // Javascript retains empty leading/trailing fields, so 
    // we trim leading/trailing whitespace first
    //
    let words   = line  . replaceAll (/"/g, "")
                        . trim       ()
                        . split      (/\s+/)
    let gaps    = words . length - 1

    //
    // Calculate spaces needed
    //
    let per_gap = gaps ? Math . floor (spaces / gaps) : 0
    let end     = spaces - gaps * per_gap

    //
    // Print results
    //
    console . log ('"' + words . join (" " . repeat (per_gap))
                       +               " " . repeat (end) + '"')
  })
