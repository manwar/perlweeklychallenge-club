#!/opt/homebrew/bin/gsed

s/ //g;             # Remove spaces
s/\.//g;            # Remove dots
s/^(.*);\1$/true/   # If both parts are equal, make it true
s/^.*;.*$/false/    # Else, make it false
