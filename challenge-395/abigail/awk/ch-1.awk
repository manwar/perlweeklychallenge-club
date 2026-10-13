#!/opt/homebrew/bin/gawk

{
    match ($0,
          /(-?[0-9]+)[ +()i]+(-?[0-9]+)[ +()i]+(-?[0-9]+)[ +()i]+(-?[0-9]+)/,
          parts)
    r = parts [1] * parts [3] - parts [2] * parts [4]
    i = parts [1] * parts [4] + parts [2] * parts [3]
    printf "%d+%s%d%si\n", r, i < 0 ? "(" : "", i, i < 0 ? ")" : ""
}
