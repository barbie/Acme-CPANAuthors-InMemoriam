#!perl -T
use strict;
use warnings;

use Test::More;

# Skip if doing a regular install
plan skip_all => "Author tests not required for installation"
    unless ( $ENV{AUTOMATED_TESTING} );

eval "use Test::CPAN::Meta";
plan skip_all => "Test::CPAN::Meta required for testing META.yml" if $@;

plan 'no_plan';

my $yaml = meta_spec_ok(undef,undef,@_);

use Acme::CPANAuthors::InMemoriam;
my $version = $Acme::CPANAuthors::InMemoriam::VERSION;

is($yaml->{version},$version,
    'META.yml distribution version matches');

if($yaml->{provides}) {
    for my $mod (keys %{$yaml->{provides}}) {
        is($yaml->{provides}{$mod}{version},$version,
            "META.yml entry [$mod] version matches");
    }
}
