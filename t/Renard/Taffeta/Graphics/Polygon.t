#!/usr/bin/env perl

use Test::Most tests => 2;
use lib 't/lib';
use TestHelper;
use List::AllUtils qw(sum);

use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Graphics::Polygon;
use Renard::Yarn::Graphene;
use Renard::Taffeta::Style::Fill;
use Renard::Taffeta::Color::Named;

my ($o_x, $o_y) = (10, 10);
my ($width, $height) = (140, 140);
my $gfx_poly = Renard::Taffeta::Graphics::Polygon->new(
	points => [
		[$o_x + 0     , $o_y + 0      ],
		[$o_x + 0     , $o_y + $height],
		[$o_x + $width, $o_y + $height],
	],
	fill => Renard::Taffeta::Style::Fill->new(
		color => Renard::Taffeta::Color::Named->new( name => 'svg:black' ),
	),
);

subtest 'Cairo' => sub {
	require Cairo;
	my ($s_width, $s_height) = (200, 200);
	my $data = TestHelper->cairo(
		render => $gfx_poly,
		width => $s_width,
		height => $s_height,
	);

	# triangle area
	my $area = 0.5 * $width * $height;

	my %counts = %{ $data->{counts} };
	# anti-aliasing
	my $marked = delete $counts{0 + 0xFF000000};
	my $unmarked = delete $counts{0};
	my $aaliased = sum values %counts;

	is($marked, $area - $aaliased / 2,
		'correct number of marked pixels');
	is($unmarked, $s_width * $s_height - $area - $aaliased / 2,
		'correct number of unmarked pixels' );
};

subtest "SVG" => sub {
	my $svg = TestHelper->svg(
		render => $gfx_poly,
		width => 200,
		height => 200
	);

	like $svg->xmlify, qr|<polygon [^>]*>|, 'XML has <polygon>';
};

done_testing;
