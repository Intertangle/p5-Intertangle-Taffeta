use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Transform::Affine2D::Rotation;
# ABSTRACT: A 2D affine rotation

use Mu;
use Renard::Yarn::Graphene;
use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Yarn::Types qw(Point AngleDegrees);

extends qw(Renard::Taffeta::Transform::Affine2D);

has angle => (
	is => 'ro',
	isa => AngleDegrees,
	required => 1,
);

lazy _axis => method() {
	Renard::Yarn::Graphene::Vec3->new(
		x => 0,
		y => 0,
		z => 1
	);
}, isa => InstanceOf['Renard::Yarn::Graphene::Vec3'];

lazy matrix => method() {
	my $rot_matrix = Renard::Yarn::Graphene::Matrix->new;
	$rot_matrix->init_rotate( $self->angle, $self->_axis );

	# Fix rotation to be 2D
	my $matrix = Renard::Yarn::Graphene::Matrix->new;
	$matrix->init_from_vec4(
		$rot_matrix->get_row(0),
		$rot_matrix->get_row(1),
		Renard::Yarn::Graphene::Vec4::z_axis(),
		$rot_matrix->get_row(3),
	);

	$matrix;
}, isa => InstanceOf['Renard::Yarn::Graphene::Matrix'];

1;
