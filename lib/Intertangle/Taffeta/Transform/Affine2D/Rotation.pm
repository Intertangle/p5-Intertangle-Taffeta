use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Transform::Affine2D::Rotation;
# ABSTRACT: A 2D affine rotation

use Mu;
use Intertangle::Yarn::Graphene;
use Renard::Incunabula::Common::Types qw(InstanceOf);
use Intertangle::Yarn::Types qw(Point AngleDegrees);

extends qw(Intertangle::Taffeta::Transform::Affine2D);

=attr angle

Angle in degrees.

Positive value for clockwise rotation and negative for counterclockwise
rotation.

=cut
has angle => (
	is => 'ro',
	isa => AngleDegrees,
	required => 1,
);

lazy _axis => method() {
	Intertangle::Yarn::Graphene::Vec3->new(
		x => 0,
		y => 0,
		z => 1
	);
}, isa => InstanceOf['Intertangle::Yarn::Graphene::Vec3'];

lazy matrix => method() {
	my $rot_matrix = Intertangle::Yarn::Graphene::Matrix->new;
	$rot_matrix->init_rotate( $self->angle, $self->_axis );

	# Fix rotation to be 2D
	my $matrix = Intertangle::Yarn::Graphene::Matrix->new;
	$matrix->init_from_vec4(
		$rot_matrix->get_row(0),
		$rot_matrix->get_row(1),
		Intertangle::Yarn::Graphene::Vec4::z_axis(),
		$rot_matrix->get_row(3),
	);

	$matrix;
}, isa => InstanceOf['Intertangle::Yarn::Graphene::Matrix'];

1;
