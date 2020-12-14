SELECT  LENGTH (sequence) || char (10) ||
        REPLACE (
            REPLACE (
                REPLACE (
                    REPLACE (
                        REPLACE (
                            REPLACE (sequence, 'A', 'x'),
                        'T', 'A'),
                    'x', 'T'),
                'G', 'y'),
            'C', 'G'),
        'y', 'C')
  FROM  DNA;
