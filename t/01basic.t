use strict;
use warnings;
use Test::More;
BEGIN {plan tests => 4};
for (qw(CPAN::AnyDBM::Index CPAN::AnyDBM::Search CPAN::AnyDBM CPAN::AnyDBM::META)) {
  require_ok($_);
}
