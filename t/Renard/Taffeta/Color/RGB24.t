#!/usr/bin/env perl

use Test::Most tests => 1;
use Renard::Incunabula::Devel::TestHelper;
use Renard::Incunabula::Common::Setup;

use Renard::Taffeta::Color::RGB24;

subtest "Build RGB24 using value" => sub {
	my @values = (
		{ value => 0xFF0000, svg => 'rgb(255,0,0)'    },
		{ value => 0xFFFF00, svg => 'rgb(255,255,0)'  },
		{ value => 0xFFFFFF, svg => 'rgb(255,255,255)'},
		{ value => 0x0000FF, svg => 'rgb(0,0,255)'},
	);
	plan tests => scalar @values;

	for my $test (@values) {
		is(
			Renard::Taffeta::Color::RGB24->new( value => $test->{value} )->svg_value,
			$test->{svg},
			"$test->{value} gives $test->{svg}",
		);
	}
};

done_testing;
