#!/usr/bin/env perl
use strict;
use Net::HTTP::Spore;
use Data::Dumper;

# Create a Neo4j client
my $client = Net::HTTP::Spore->new_from_spec('neo4j.json', trace => '1=log.txt');

# Create a new node
my $node = $client->create_node();
my $body = $node->body;
print Dumper $body;

# Get an existing node
my $existing_node = $client->get_node( node => 8 );
my $node_body	  = $existing_node->body;
print Dumper $node_body;


