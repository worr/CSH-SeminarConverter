use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'CSH::SeminarConverter',
    AUTHOR              => q{YOUR NAME <youremail@example.com>},
    VERSION_FROM        => 'lib/CSH/SeminarConverter.pm',
    ABSTRACT            => 'YOUR APPLICATION ABSTRACT',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Dancer'     => 1.3111,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CSH-SeminarConverter-*' },
);
