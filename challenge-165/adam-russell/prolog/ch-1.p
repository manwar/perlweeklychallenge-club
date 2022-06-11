svg-->svg_begin, svg_body, svg_end.
svg_body-->[].
svg_body-->svg_line(_, _, _, _), svg_body.
svg_body-->svg_point(_, _), svg_body.
svg_begin-->['<?xml version="1.0" encoding="UTF-8" standalone="yes"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"><svg height="100%" width="100%" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'].
svg_point(X, Y)-->['<circle cx="', X,'" cy="', Y, '" r="1" />'].
svg_line(X1, Y1, X2, Y2)-->['<line x1="', X1, '" x2="', X2, '" y1="', Y1, '" y2="', Y2, '" style="stroke:#006600;" />'].
svg_end-->['</svg>'].

plot([], SVGAccum, SVG):-
    phrase(svg_begin, Begin),
    flatten([Begin|SVGAccum], SVG).
plot([H|T], SVGAccum, SVG):-
    length(H, 2),
    [X, Y] = H,
    phrase(svg_point(X, Y), Point),
    plot(T, [Point|SVGAccum], SVG).
plot([H|T], SVGAccum, SVG):-
    length(H, 4),
    [X1, Y1, X2, Y2] = H,
    phrase(svg_line(X1, Y1, X2, Y2), Line),
    plot(T, [Line|SVGAccum], SVG).
plot(Lines, SVG):-
    phrase(svg_end, End),
    plot(Lines, [End], SVG).

main:-
     plot([[53,10], [53, 10, 23, 30], [23, 30]], SVG),
     maplist(write, SVG), nl,
     halt.
