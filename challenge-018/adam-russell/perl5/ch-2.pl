use PriorityQueue;
my $pq = new PriorityQueue();
$pq->initialize();
$pq->insert_with_priority(7, "sleep");  
$pq->insert_with_priority(4, "go to the gym");  
$pq->insert_with_priority(3, "work on blog");  
$pq->insert_with_priority(5, "drink water");  
$pq->insert_with_priority(1, "eat pizza");  
$pq->insert_with_priority(2, "work on perl weekly challenge");  
$pq->insert_with_priority(6, "clean dishes");  
for(0 .. 6){
    my $data = $pq->pull_highest_priority_element();
    printf("$data\n");
}  
