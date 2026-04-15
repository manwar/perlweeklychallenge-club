#! /usr/bin/node

"use strict"

function validtag(a) {
    let p = "#";
    let up = false;
    for (let c of a) {
        if (/[A-Za-z]/.test(c)) {
            let cc = c;
            if (up) {
                cc = cc.toUpperCase();
                up = false;
            } else {
                cc = cc.toLowerCase();
            }
            p += cc;
        } else if (c == " " && p.length > 1) {
            up = true;
        }
    }
    if (p.length > 100) {
        p = p.slice(0, 100);
    }
    return p;
}

if (validtag('Cooking with 5 ingredients!') == '#cookingWithIngredients') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtag('the-last-of-the-mohicans') == '#thelastofthemohicans') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtag('  extra spaces here') == '#extraSpacesHere') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtag('iPhone 15 Pro Max Review') == '#iphoneProMaxReview') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!') == '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
