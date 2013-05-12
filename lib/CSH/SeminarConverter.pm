package CSH::SeminarConverter;

use strict;
use warnings;
use v5.12;

use CSH::SeminarConverter::Converter;
use Dancer ':syntax';
use File::Spec;
use JSON::Any;
use Try::Tiny;

our $VERSION = '1.0';

post '/github' => sub {
    my $json = JSON::Any->new;
    my $params = $json->decode(param("payload"));
    my $path = File::Spec->catfile(setting("clone_path"), $params->{repository}->{name});

    try {
        CSH::SeminarConverter::Converter::pull_git_repo($params->{repository}->{url}, $path);
    } catch {
        error "Could not clone: $_\n";
    };

    try {
        CSH::SeminarConverter::Converter::convert_all($path);
    } catch {
        error "Could not convert: $_\n";
    };
};

true;
