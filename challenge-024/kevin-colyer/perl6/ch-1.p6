# PWC 24.1 : Create a smallest script in terms of size that on execution doesn’t throw any error. The script doesn’t have to do anything special. You could even come up with smallest one-liner.
#
# A simple tac command accepting multiple text files: 35 chars.
@*ARGS.map: *.IO.lines.reverse».say
