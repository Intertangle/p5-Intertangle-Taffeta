#!/usr/bin/env perl

use Test::Most tests => 5;
use Renard::Incunabula::Common::Setup;
use Renard::Yarn::Graphene;
use Renard::Taffeta::Transform::Affine2D;

subtest "Build affine transform using Graphene::Matrix" => sub {
	my $t = Renard::Taffeta::Transform::Affine2D->new(
		matrix => Renard::Yarn::Graphene::Matrix->new_from_arrayref([
			[ 2, 0 , 0 , 0 ],
			[ 0, 5 , 0 , 0 ],
			[ 0, 0 , 1 , 0 ],
			[ 3, 4,  0,  1 ],
		])
	);

	is $t->matrix * Renard::Yarn::Graphene::Point->new( x => 0, y => 0 ), [3, 4];
	is $t->matrix * Renard::Yarn::Graphene::Point->new( x => 1, y => 1 ), [2 + 3, 5 + 4];
};

subtest "Check that matrix is affine" => sub {
	throws_ok {
		my $t = Renard::Taffeta::Transform::Affine2D->new(
			matrix => Renard::Yarn::Graphene::Matrix->new_from_arrayref([
				[ 4, 4 , 0 , 0 ],
				[ 4, 4 , 0 , 0 ],
				[ 0, 0 , 1 , 0 ],
				[ 4, 4,  0,  4 ],
			])
		);
	} qr/Not a 2D affine transform matrix/;

	throws_ok {
		my $t = Renard::Taffeta::Transform::Affine2D->new(
			matrix => Renard::Yarn::Graphene::Matrix->new_from_arrayref([
				[ 4, 4 , 0 , 1 ],
				[ 4, 4 , 0 , 0 ],
				[ 0, 0 , 1 , 0 ],
				[ 4, 4,  0,  1 ],
			])
		);
	} qr/Not a 2D affine transform matrix/;

	lives_ok {
		my $t = Renard::Taffeta::Transform::Affine2D->new(
			matrix => Renard::Yarn::Graphene::Matrix->new_from_arrayref([
				[ 4, 4 , 0 , 0 ],
				[ 4, 4 , 0 , 0 ],
				[ 0, 0 , 1 , 0 ],
				[ 4, 4,  0,  1 ],
			])
		);
	};
};


subtest "Build matrix_abcdef" => sub {
	my $t = Renard::Taffeta::Transform::Affine2D->new(
		matrix_abcdef => {
			a => 6, c => 8, e => 3,
			b => 7, d => 9, f => 4,
		}
	);
	my $comma_space = qr/,\s*/;
	my $decimal_zero = qr/\.0*/;
	like $t->svg_transform,
		qr/matrix\(
			6$decimal_zero$comma_space
			7$decimal_zero$comma_space
			8$decimal_zero$comma_space
			9$decimal_zero$comma_space
			3$decimal_zero$comma_space
			4$decimal_zero
		\)/x
	;
	pass;
};

subtest "Build matrix_xy" => sub {
	my $t = Renard::Taffeta::Transform::Affine2D->new(
		matrix_xy => {
			xx => 6, yx => 8, x0 => 3,
			xy => 7, yy => 9, y0 => 4,
		}
	);

	is "" . $t->matrix, <<EOF;
[
    6 8 0 0
    7 9 0 0
    0 0 1 0
    3 4 0 1
]
EOF


};

subtest "is identity" => sub {
	ok(Renard::Taffeta::Transform::Affine2D->new()->is_identity, 'default');
	ok(Renard::Taffeta::Transform::Affine2D->new(
		matrix => Renard::Yarn::Graphene::Matrix->new_from_arrayref([
			[ 1, 0 , 0 , 0 ],
			[ 0, 1 , 0 , 0 ],
			[ 0, 0 , 1 , 0 ],
			[ 0, 0,  0,  1 ],
		])
	)->is_identity, 'construct matrix');
	ok(Renard::Taffeta::Transform::Affine2D->new( matrix_xy => { } )->is_identity, 'construct matrix_xy');
	ok(Renard::Taffeta::Transform::Affine2D->new( matrix_abcdef => { } )->is_identity, 'construct matrix_abcdef');
};

done_testing;
