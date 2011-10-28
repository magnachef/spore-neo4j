#!/usr/bin/env perl
use strict;
use Net::HTTP::Spore;
use Data::Dumper;
use Try::Tiny;

# Create a Neo4j client
my $client = Net::HTTP::Spore->new_from_spec('neo4j.json', trace => '1=log.txt');
$client->enable('Format::JSON');

# test the root method
my $root = $client->root();
print Dumper $root->body;

# Create a new node
create_node();

# Create a new node with some properties
create_node({name => 'foo'});

# Set properties on node 1
$client->set_node_properties(id => 1, payload => {name => 'baz'});

# Get the properties now
my $node = $client->node_properties(id => 1);
print Dumper $node->body;

# Let's delete the properties
$node = $client->delete_node_properties(id => 1);
$node = $client->node_properties(id => 1);
print Dumper $node->body;

# Get an existing node
my $existing_node = $client->get_node( node => 1 );
my $node_body	  = $existing_node->body;
print Dumper $node_body;

# Get the property 'name' on the second node
$node = $client->node_property(id => 2, property => 'name');
print Dumper $node->body;

sub create_node {
    my $properties = shift || {};
    my ($node, $body);
    # it's better to try/catch spore's method call
    # if there is an error, the client throw an exception
    try {
        $node = $client->create_node(payload => $properties);
        $body = $node->body;
        print Dumper $body;
    }catch{
        print Dumper $_;
    };
}


