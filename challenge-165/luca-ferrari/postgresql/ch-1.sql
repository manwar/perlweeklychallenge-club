-- Perl Weekly Challenge 165
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc165;


TRUNCATE points;

INSERT INTO points
VALUES
(53,10, NULL, NULL)
,(53,10,23,30)
,(23,30, NULL, NULL)
;



CREATE OR REPLACE FUNCTION
pwc165.task1_plpgsql()
RETURNS TEXT
AS $CODE$
DECLARE
        svg text;
        p points%rowtype;
BEGIN
        SELECT '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="400" width="400" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">'
       INTO svg;

       FOR p IN SELECT * FROM points LOOP
               IF p.x1 IS NOT NULL AND p.y1 IS NOT NULL AND p.x2 IS NOT NULL AND p.y2 IS NOT NULL THEN
                  -- line
                  SELECT svg
                         || format( '<polyline points="%s %s %s %s" stroke="#ff0000" stroke-width="6" />',
                                     p.x1, p.y1, p.x2, p.y2 )
                 INTO SVG;
              END IF;

              IF p.x1 IS NOT NULL AND p.y1 IS NOT NULL THEN
                 -- point
                 SELECT svg
                        || format( '<circle r="4" cx="%s" cy="%s" stroke-width="0" fill="#000000" />', p.x1, p.y1 )
                 INTO svg;
              END IF;

              IF p.x2 IS NOT NULL AND p.y2 IS NOT NULL THEN
                 -- point
                 SELECT svg
                        || format( '<circle r="4" cx="%s" cy="%s" stroke-width="0" fill="#000000" />', p.x2, p.y2 )
                INTO svg;
             END IF;
       END LOOP;

RETURN svg;
END
$CODE$
LANGUAGE plpgsql;
