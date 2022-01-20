        SELECT v
        FROM generate_series( 1, 10 ) v
        WHERE
        v IN ( 2, 4, 6 )

        UNION

        SELECT v
        FROM generate_series( 11, 19 ) v
        WHERE v IN ( 12 )

        UNION

        SELECT v
        FROM generate_series( 20, 100 ) v
        WHERE
        v % 10 IN ( 2, 4, 6 )
        AND ( v / 10 )::int  IN ( 3, 4, 5, 6 );
