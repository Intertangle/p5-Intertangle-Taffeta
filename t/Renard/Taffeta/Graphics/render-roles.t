#!/usr/bin/env perl

use Test2::V0;
use Test2::Tools::Class;
use lib 't/lib';
use TestHelper;

use Renard::Yarn::Graphene;
use Renard::Incunabula::Common::Setup;
use Module::List qw(list_modules);
use Module::Load;

my @modules =
	grep { $_ !~ /::Role::/ }
	keys %{ list_modules( "Renard::Taffeta::Graphics::", { list_modules => 1, recurse => 1 } ) };

for my $module (@modules) {
	subtest "$module" => sub {
		load $module;
		isa_ok $module, 'Renard::Taffeta::Graphics';
		DOES_ok $module,
			'Renard::Taffeta::Graphics::Role::CairoRenderable',
			'Renard::Taffeta::Graphics::Role::SVGRenderable',
			'Renard::Taffeta::Graphics::Role::WithTransform',
		;
	};
}

done_testing;
