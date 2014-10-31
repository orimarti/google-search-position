#!/usr/bin/env perl

use Search::Position;
use Data::Dumper;
use Data::Printer;
use LWP::Simple;
use JSON qw(from_json);

my $search_params = Search::Position->new_with_options();

my $found = 0;
my $count = 10;
my $start = 1;
my $max = 100; # Max permitted for google
while ((! $found) && $start < $max){
  my $url = 'https://www.googleapis.com/customsearch/v1?key=' . $search_params->api_key . '&cx=' .$search_params->search_engine . '&q=' . $search_params->query_string . ($start == 1?  "":  '&num=' . $count . '&start=' . $start);
  my $response = from_json(get($url));
  my $offset = 0;
  foreach my $result (@{$response->{items}}) {
    if (index($result->{link}, $search_params->{web_page}) != -1){
      $found = 1;
      print $start+$offset;
      exit(0);
    }
    $offset ++;
  }
  $start = $response->{queries}->{nextPage}->[0]->{startIndex};
  $count = $response->{queries}->{nextPage}->[0]->{count};
}
print "200";
exit(1);
