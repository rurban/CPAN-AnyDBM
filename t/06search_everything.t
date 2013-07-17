# $Id: 06search_everything.t 34 2011-06-13 04:35:00Z stro $

use strict;
use warnings;
use Test::More;
use Cwd;
use CPAN::UnQLite::Search;
use FindBin;
use File::Spec::Functions;
use lib "$FindBin::Bin/lib";
use TestSQL qw($dists $mods $auths vcmp);
use CPAN::UnQLite::DBI::Search;
use CPAN::UnQLite::DBI qw($dbh);

my $cwd = getcwd;
my $CPAN = catfile $cwd, 't', 'cpan';

plan tests => 14;
my $db_name = 'cpandb.sql';
my $db_dir = $cwd;

my $cdbi = CPAN::UnQLite::DBI::Search->new(db_name => $db_name,
                                          db_dir => $db_dir);

my $query = CPAN::UnQLite::Search->new(db_name => $db_name,
                                      db_dir => $db_dir);
ok(defined $query);
isa_ok($query, 'CPAN::UnQLite::Search');

my $results;

my $everything = q{.};
my $all_res_qty = { 'author' => 4, 'dist' => 92, 'module' => 544, };
for my $mode (qw(author dist module)) {
  {
    my $type = 'name';
    $query->query(mode => $mode, $type => $everything);
    $results = $query->{results};
    ok(not defined $results);
  }
  {
    my $type = 'query';
    $query->query(mode => $mode, $type => $everything);
    $results = $query->{results};
    ok(defined $results);
    isa_ok($results, 'ARRAY');
    is(scalar @{$results}, $all_res_qty->{$mode}, 'Correct number of query results');
  }
}
