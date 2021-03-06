use strict;
use warnings;

use ExtUtils::MakeMaker;

my $goners = join ' ', qw(
    cpandb.dbm
    t/dot-cpan/cpandb.dbm
    t/dot-cpan/FTPstats.yml
    t/dot-cpan/CPAN/MyConfig.pm
    t/dot-cpan/cpan_dbm_log.*
    t/dot-cpan/sources/authors/01mailrc.txt.gz
    t/dot-cpan/sources/modules/02packages.details.txt.gz
    t/dot-cpan/sources/modules/03modlist.data.gz
);

my %opts = (
    'NAME'          => 'CPAN::AnyDBM',
    'VERSION_FROM'  => 'lib/CPAN/AnyDBM.pm',
    'EXE_FILES'     => ['bin/cpandbm'],
    'PL_FILES'      => {},
    'dist'          => {
        'SUFFIX'        => 'gz',
        'COMPRESS'      => 'gzip -9f',
    },
    'clean'         => {
        'FILES'          => $goners
    },
    'SIGN'          => 1,
);

my $eu_version = $ExtUtils::MakeMaker::VERSION;
$eu_version =~ s/_//msgx;

if ($eu_version gt '5.43') {
    %opts = (%opts, 
        'ABSTRACT_FROM' => 'lib/CPAN/AnyDBM.pm',
        'AUTHOR'        => 'Reini Urban <rurban@cpan.org>',
    );
    if ($eu_version gt '6.46') {
      %opts = (%opts, 
               'META_MERGE'  =>  {
                 resources =>  {
                   repository  => 'http://github.com/rurban/CPAN-AnyDBM',
                   license     => 'http://dev.perl.org/licenses/',
                 },
               }
        );
    }
}

my $prereqs = {
    'AnyDBM_File'           => 1.00,
    'File::Spec'            => 0,
    'Archive::Tar'          => 1.54,
    'IO::Zlib'              => 0,
    'Compress::Zlib'        => 0,
    'CPAN::DistnameInfo'    => 0.09,
    'File::HomeDir'         => 0,
    'LWP::Simple'           => 0,
    'CPAN::Index'           => 1.93,
    'parent'                => 0,
};

WriteMakefile( %opts, 'PREREQ_PM' => $prereqs);
