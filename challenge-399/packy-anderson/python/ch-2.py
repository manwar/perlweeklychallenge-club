#!/usr/bin/env python

import re

def longest_absolute_path(fs):
  files, level, explain = [], [], ""
  for entry in fs.split("\n"):
    deep = entry.count("\t") # count the tabs
    if deep > 0:
      entry = entry.replace("\t", "") # eliminate the tabs
      dir = level[deep-1]
      entry = "/".join([dir, entry])
      if len(files) > 0 and dir == files[-1]:
        explain += (f'"{dir}" is a directory ' +
                    "(it has children beneath it).\n")
        files.pop()
    level.insert(deep, entry)
    if re.search(r"[^/]+\.[^/]+$", entry):
      files.append(entry)
  if len(files) == 0:
    return(
      0,
      "There are no files in the system (a file must contain " +
      "a . character\nseparating a name and extension).\n" +
      "Since there are no files, the answer is 0."
    )
  explain += "Found File Paths:\n"
  explain += "\n".join(
    [ f'    "{s}" (length {len(s)})' for s in files ]
  )
  return max([len(s) for s in files ]), explain

def solution(fs):
  display = fs.replace("\n", "\\n").replace("\t", "\\t")
  print(f'Input: $fs = "{display}"')
  count, explain = longest_absolute_path(fs)
  print(f'Output: {count}\n\n{explain}')

print('Example 1')
solution("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2")

print('\nExample 2')
solution("file1.txt\nfile2.ext\na.png")

print('\nExample 3')
solution("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png")

print('\nExample 4')
solution("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt")

print('\nExample 5')
solution("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt")
