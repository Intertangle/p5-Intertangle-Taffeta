#!/usr/bin/env perl

use Test::Most tests => 3;

use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Graphics::Rectangle;
use Renard::Yarn::Graphene;
use Renard::Taffeta::Style::Fill;
use Renard::Taffeta::Color::Named;

my ($x, $y) = (10, 20);
my ($width, $height) = (30, 40);
my $gfx_rect = Renard::Taffeta::Graphics::Rectangle->new(
	position => Renard::Yarn::Graphene::Point->new( x => $x, y => $y ),
	width => $width, height => $height,
	fill => Renard::Taffeta::Style::Fill->new(
		color => Renard::Taffeta::Color::Named->new( name => 'svg:black' ),
	),
);

subtest "Attributes" => sub {
	is $gfx_rect->bounds->width, $width, 'check width';
	is $gfx_rect->bounds->height, $height, 'check height';
};

subtest "Cairo" => sub {
	require Cairo;
	my ($s_width, $s_height) = (100, 100);
	my $surface = Cairo::ImageSurface->create('argb32', $s_width, $s_height);
	my $cr = Cairo::Context->create( $surface );

	$gfx_rect->render_cairo( $cr );

	my @data = unpack 'L*', $surface->get_data; # uint32_t
	use List::AllUtils qw(count_by sum);
	my %counts = count_by { $_ } @data;
	is( $counts{0 + 0xFF000000}, $width * $height,
		'correct number of marked pixels');
	is( $counts{0}, $s_width * $s_height - $width * $height,
		'correct number of unmarked pixels' );
};

subtest "SVG" => sub {
	require SVG;
	SVG->import;
	my $svg = SVG->new( width => 100, height => 100 );

	$gfx_rect->render_svg( $svg );

	like $svg->xmlify, qr|<rect [^>]*>|, 'XML has <rect>';
};

done_testing;
