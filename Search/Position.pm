package Search::Position {
  use Moose;
  use MooseX::StrictConstructor;

  with 'MooseX::Getopt';

  has api_key => (is => 'ro', isa => 'Str', required => 1);
  has web_page => (is => 'ro', isa => 'Str', required => 1);
  has query_string => (is => 'ro', isa => 'Str', required => 1);
  has search_engine => (is => 'ro', isa => 'Str', required => 1);
}

1;
