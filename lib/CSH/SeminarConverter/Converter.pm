package CSH::SeminarConverter::Converter;

use strict;
use warnings;
use v5.12;

use Carp;
use Cwd;
use Dancer ':syntax';
use File::Basename;
use File::Find;
use File::Spec;

sub pull_git_repo {
    my ($url, $path) = @_;

    if ( -d $path) {
        qx/rm -rf $path/;
    }

    chdir(dirname($path));
    qx/git clone --depth 1 $url $path/;
    if ( not -d File::Spec->catfile($path, ".git")) {
        error "Could not create git repository";
    }
}

sub convert_one {
    my ($filename, $type) = @_;

    return (system("unoconv -f $type \"$filename\"") == 0);
}

sub convert {
    my $filename = $File::Find::name;

    given ($filename) {
        when (/\.odp$/) {
            info "Converting $filename";
            if (not convert_one($filename, "ppt")) {
                warning "Could not convert to ppt";
            } else {
                info "Converted $filename";
            }

            if (not convert_one($filename, "pdf")) {
                warning "Could not convert to pdf";    
            } else {
                info "Converted $filename";
            }
        }

        when (/\.pptx?$/) {
            info "Converting $filename";
            if (not convert_one($filename, "odp")) {
                warning "Could not convert to odp";
            } else {
                info "Converted $filename";
            }

            if (not convert_one($filename, "pdf")) {
                warning "Could not convert to pdf";    
            } else {
                info "Converted $filename";
            }
        }
    }
}

sub convert_all {
    my $base = shift;
    info 'Starting conversion';

    find(\&convert, $base);
}

1;
