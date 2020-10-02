use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Transform::Affine2D::Scaling;
# ABSTRACT: A 2D affine scaling

use Mu;
use Intertangle::Yarn::Graphene;
use Renard::Incunabula::Common::Types qw(InstanceOf);
use Intertangle::Yarn::Types qw(Vec2);

extends qw(Intertangle::Taffeta::Transform::Affine2D);

=attr scale

A C<Vec2> indicating the scaling amount in x and y respectively.

=cut
has scale => (
	is => 'ro',
	isa => Vec2,
	coerce => 1,
	required => 1,
);

lazy matrix => method() {
	my $matrix = Intertangle::Yarn::Graphene::Matrix->new;
	$matrix->init_scale( $self->scale->x, $self->scale->y, 1 );
	$matrix;
}, isa => InstanceOf['Intertangle::Yarn::Graphene::Matrix'];

1;
