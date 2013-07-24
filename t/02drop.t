use strict;
use warnings;
use Test::More;
use AnyDBM_File;
use Fcntl;
BEGIN {plan tests => 7};

my $db_name = 't/dot-cpan/cpandb.dbm';
my %dbh;
tie %dbh, 'AnyDBM_File', $db_name, O_CREAT|O_RDWR;
my $dbh = \%dbh;
ok($dbh);
isa_ok($dbh, 'AnyDBM_File');
my @tables = qw(mods auths chaps dists info);
for my $table(@tables) {
  if ($dbh->fetch($table)) {
    $dbh->delete($table);
    pass("Drop $table");
  } else {
    pass("Skip $table");
  }
}
undef $dbh;
