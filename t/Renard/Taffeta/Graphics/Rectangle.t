#!/usr/bin/env perl

use Test::Most tests => 3;
use lib 't/lib';
use TestHelper;

use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Graphics::Rectangle;
use Renard::Yarn::Graphene;
use Renard::Taffeta::Style::Fill;
use Renard::Taffeta::Color::Named;

use Renard::Taffeta::Transform::Affine2D;
use Renard::Taffeta::Transform::Affine2D::Scaling;
use Renard::Taffeta::Transform::Affine2D::Translation;

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
	is $gfx_rect->size->width, $width, 'check width';
	is $gfx_rect->size->height, $height, 'check height';
};

subtest "Render" => sub {
	subtest "Cairo" => sub {
		require Cairo;
		my ($s_width, $s_height) = (100, 100);
		my $data = TestHelper->cairo(
			render => $gfx_rect,
			width => $s_width,
			height => $s_height,
		);

		my %counts = %{ $data->{counts} };
		is( $counts{0 + 0xFF000000}, $width * $height,
			'correct number of marked pixels');
		is( $counts{0}, $s_width * $s_height - $width * $height,
			'correct number of unmarked pixels' );
	};

	subtest "SVG" => sub {
		my $svg = TestHelper->svg(
			render => $gfx_rect,
			width => 100,
			height => 100
		);

		like $svg->xmlify, qr|<rect [^>]*>|, 'XML has <rect>';
	};
};

subtest "Transform" => sub {
	subtest "Identity" => sub {
		my $rect = Renard::Taffeta::Graphics::Rectangle->new(
			transform => Renard::Taffeta::Transform::Affine2D->new,
			width => 10,
			height => 20,
		);

		my $tb = $rect->transformed_bounds;
		is $tb->origin, [0, 0], 'transform origin still at (0,0)';
		is $tb->size, [10, 20], 'transform size is identity size';
	};

	subtest "Scale x,y" => sub {
		my $rect = Renard::Taffeta::Graphics::Rectangle->new(
			transform => Renard::Taffeta::Transform::Affine2D::Scaling->new(
				scale => [ 2, 3 ],
			),
			width => 10,
			height => 20,
		);

		my $tb = $rect->transformed_bounds;
		is $tb->origin, [0, 0], 'transform origin still at (0,0)';
		is $tb->size, [20, 60], 'transform size is scaled';
	};

	subtest "Translate x,y" => sub {
		my $rect = Renard::Taffeta::Graphics::Rectangle->new(
			transform => Renard::Taffeta::Transform::Affine2D::Translation->new(
				translate => [ 100, 200, ],
			),
			width => 10,
			height => 20,
		);

		my $tb = $rect->transformed_bounds;
		is $tb->origin, [100, 200], 'transform origin translated to (100,200)';
		is $tb->size, [10, 20], 'transform size is identity size';
	};
};

done_testing;
