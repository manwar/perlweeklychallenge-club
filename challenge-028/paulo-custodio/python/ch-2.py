#!/usr/bin/python3

# Challenge 028

# Task #2
# Write a script to display Digital Clock. Feel free to be as creative as you
# can when displaying digits. We expect bare minimum something like "14:10:11".

from datetime import datetime
import time

chars = {
    ' ': ["      ",
          "      ",
          "      ",
          "      ",
          "      "],
    '0': ["  ___ ",
          " |   |",
          " |   |",
          " |   |",
          " |___|"],
    '1': ["      ",
          "     |",
          "     |",
          "     |",
          "     |"],
    '2': ["  ___ ",
          "     |",
          "  ___|",
          " |    ",
          " |___ "],
    '3': ["  ___ ",
          "     |",
          "  ___|",
          "     |",
          "  ___|"],
    '4': ["      ",
          " |   |",
          " |___|",
          "     |",
          "     |"],
    '5': ["  ___ ",
          " |    ",
          " |___ ",
          "     |",
          "  ___|"],
    '6': ["  ___ ",
          " |    ",
          " |___ ",
          " |   |",
          " |___|"],
    '7': ["  ___ ",
          "     |",
          "     |",
          "     |",
          "     |"],
    '8': ["  ___ ",
          " |   |",
          " |___|",
          " |   |",
          " |___|"],
    '9': ["  ___ ",
          " |   |",
          " |___|",
          "     |",
          "     |"],
    ':': ["      ",
          "      ",
          "   .  ",
          "   .  ",
          "      "],
}

CLEAR = "\x1b[H\x1b[2J"
HOME  = "\x1b[H"

def banner(text):
    for row in range(len(chars[' '])):
        for c in text:
            print(chars[c][row], end="")
        print("")

print(CLEAR, end="")
while True:
    now = datetime.now()
    print(HOME, end="")
    banner(now.strftime("%H:%M:%S"))
    time.sleep(0.5)
