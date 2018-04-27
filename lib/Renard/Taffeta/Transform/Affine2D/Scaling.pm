use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Transform::Affine2D::Scaling;
# ABSTRACT: A 2D affine scaling

use Mu;
use Renard::Yarn::Graphene;
use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Yarn::Types qw(Vec2);

extends qw(Renard::Taffeta::Transform::Affine2D);

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
	my $matrix = Renard::Yarn::Graphene::Matrix->new;
	$matrix->init_scale( $self->scale->x, $self->scale->y, 1 );
	$matrix;
}, isa => InstanceOf['Renard::Yarn::Graphene::Matrix'];

1;
