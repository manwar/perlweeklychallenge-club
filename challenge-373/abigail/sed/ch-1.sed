#!/opt/homebrew/bin/gsed

s/\s+//g;           # Remove white space
s/\.//g;            # Remove dots
s/^(.*);\1$/true/   # If both parts are equal, make it true
s/^.*;.*$/false/    # Else, make it false
