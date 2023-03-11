// The Weekly Challenge 203
// Task 2 Copy Directory
// Usage: node ch-2.js source target
// 2023 March 7th

const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const source = process.argv[2];
const target = process.argv[3];

const dir_walk = (head) => {
  if (fs.lstatSync(head).isDirectory()) {
    const dirname = head.split("/")[head.split("/").length-1];
    const relpath = path.relative(source, head);
    if (source != head) {
      exec(`cd ${path.join(target, relpath, '..')} && mkdir ${dirname}`);
    }
    const filenames = fs.readdirSync(head);
    filenames.forEach( f => {
      dir_walk(path.join(head, f));
    });
  }
}

dir_walk(source);
