use Test2::V0 -target => 'Knight', -srand => 1234;

my $treasures
    = [ [ 0, 1 ], [ 1, 0 ], [ 1, 1 ], [ 2, 1 ], [ 3, 2 ], [ 5, 4 ] ];
my $collected_treasures = [ [ 1, 1 ] ];

my $k = Knight->new(
    treasures           => $treasures,
    collected_treasures => $collected_treasures
);

note 'We control random so this is the order of RAND';

subtest 'move' => sub {
    is $k->move( 5, 5 ), [ 3, 4 ], 'Direction 5, down  left';
    is $k->move( 5, 5 ), [ 7, 6 ], 'Direction 1, up    right';
    is $k->move( 5, 5 ), [ 6, 7 ], 'Direction 2, right up';
    is $k->move( 5, 5 ), [ 6, 7 ], 'Direction 2, right up';
    is $k->move( 5, 5 ), [ 6, 3 ], 'Direction 7, left  up';
    is $k->move( 5, 5 ), [ 6, 7 ], 'Direction 2, right up';
    is $k->move( 5, 5 ), [ 7, 4 ], 'Direction 0, up    left';
    is $k->move( 5, 5 ), [ 3, 6 ], 'Direction 4, down  right';

    is $k->move( 0, 0 ), [ 1, 2 ], 'From 0,0 -> Direction 4, down  right';
};

subtest 'has_treasure' => sub {
    is $k->has_treasure( 0, 1 ), 1, '0,1 Has a treasure';
    is $k->has_treasure( 5, 5 ), 0, '5,5 Has no treasure';
};

subtest 'have_we_got_this_teasure' => sub {
    $k->collected_treasures( [ [ 1, 1 ] ] );
    is $k->have_we_got_this_treasure( 0, 1 ), 0,
        'return 0 if we don\'t have this treasure';
    is $k->have_we_got_this_treasure( 1, 1 ), 1,
        'return 1 if we do have this treasure';

};

subtest 'add_to_collected_treasure' => sub {
    my $before = $k->collected_treasures;
    #push @{$k->collected_treasures}, [2,2];
    $k->collect_treasure( 2, 2 );
    is $k->collected_treasures, [ [ 1, 1 ], [ 2, 2 ] ],
        'Added an entry to the collected treasures';
};

subtest 'go' => sub {
    my $k2  = Knight->new( treasures => $treasures );
    my $res = $k2->go;
    is $res->{moves}, 257,
        'Given control of random we know we should have 257 moves';
};

done_testing;
