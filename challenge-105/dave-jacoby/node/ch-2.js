"use strict";

let name = get_name(process.argv);
name_game(name);

function name_game(name) {
  name = name.toLowerCase();

  if ( name === 'chuck' ) {
    throw 'Name not allowed'
  }

  let lyrics = function () {
    /*
        NAME, NAME, bo-BY
        Bonanna-fanna fo-FY
        Fee fi mo-MY
        NAME!
    */
  }
    .toString()
    .split(/\/\*/)[1]
    .split(/\*\//)[0];

  let Name = ucfirst(name);
  let i = Name.substr(0, 1);
  let inits = Name.match(/^([^AEIOUaeiou]+)/);
  let y = Name.replace(/^([^AEIOUaeiou]+)/, "");

  let by = "B" + y;
  let fy = "F" + y;
  let my = "M" + y;

  let vowels = {
    A: 1,
    E: 1,
    I: 1,
    O: 1,
    U: 1,
  };

  if (0) {
  } else if (i === "B") {
    by = ucfirst(y);
  } else if (i === "F") {
    by = ucfirst(y);
  } else if (i === "M") {
    by = ucfirst(y);
  } else if (vowels[i]) {
    console.log("VOWEL");
    by = "B" + name;
    fy = "F" + name;
    my = "M" + name;
  }

  lyrics = lyrics.replace(/NAME/g, Name);
  lyrics = lyrics.replace(/BY/, by);
  lyrics = lyrics.replace(/FY/, fy);
  lyrics = lyrics.replace(/MY/, my);

  console.log(lyrics);
}

function get_name(argv) {
  let path = require("path");
  let programName = path.basename(__filename);
  let re = new RegExp(programName, "g");
  let name = argv.pop();

  if (name.match(re) ? 1 : 0) {
    name = "Dave";
  }
  return name;
}

function ucfirst(str) {
  str = str.toLowerCase();
  var firstLetter = str.substr(0, 1);
  return firstLetter.toUpperCase() + str.substr(1);
}
