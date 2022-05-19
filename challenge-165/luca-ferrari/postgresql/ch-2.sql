-- Perl Weekly Challenge 165
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc165;

CREATE TABLE IF NOT EXISTS points( x1 int, y1 int, x2 int, y2 int );

TRUNCATE points;

INSERT INTO points( x1, y1 )
VALUES
(333,129) ,( 39,189) ,(140,156) ,(292,134) ,(393,52 ) ,(160,166) ,(362,122) ,( 13,193)
,(341,104) ,(320,113) ,(109,177) ,(203,152) ,(343,100) ,(225,110) ,( 23,186) ,(282,102)
,(284,98)  ,(205,133) ,(297,114) ,(292,126) ,(339,112) ,(327,79 ) ,(253,136) ,( 61,169)
,(128,176) ,(346,72 ) ,(316,103) ,(124,162) ,( 65,181) ,(159,137) ,(212,116) ,(337,86 )
,(215,136) ,(153,137) ,(390,104) ,(100,180) ,( 76,188) ,( 77,181) ,( 69,195) ,( 92,186)
,(275,96)  ,(250,147) ,( 34,174) ,(213,134) ,(186,129) ,(189,154) ,(361,82 ) ,(363,89 )
;


CREATE OR REPLACE FUNCTION
pwc165.task2_plpgsql()
RETURNS TEXT
AS $CODE$
DECLARE
        x  float := 0;
        y  float := 0;
        xx float := 0;
        xy float := 0;
        m  float := 0;
        b  float := 0;
        c  int   := 0;

        p  points%rowtype;
BEGIN

        FOR p IN SELECT x1, y1 FROM points LOOP
            x  := x + p.x1;
            y  := y + p.y1;
            xy := xy + p.x1 + p.y1;
            xx := xx + p.x1 * p.x1;
            c  := c + 1;
        END LOOP;

        m := ( c * xy - x * y ) / ( c * xx - x * x );
        b := ( y - m * x ) / c;

        INSERT INTO points( x1, y1, x2, y2 )
        SELECT 0, b, 100, 100 * m + b;

        RETURN pwc165.task1_plpgsql();
END
$CODE$
LANGUAGE plpgsql;
