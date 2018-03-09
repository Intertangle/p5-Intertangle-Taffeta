use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Transform::Affine2D::Translation;
# ABSTRACT: A 2D affine translation

use Mu;
use Renard::Yarn::Graphene;
use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Yarn::Types qw(Point);

extends qw(Renard::Taffeta::Transform::Affine2D);

=attr translate

A C<Point> indicating where to translate to.

=cut
has translate => (
	is => 'ro',
	isa => Point,
	coerce => 1,
	required => 1,
);

lazy matrix => method() {
	my $matrix = Renard::Yarn::Graphene::Matrix->new;
	$matrix->init_translate( $self->translate->to_Point3D );
	$matrix;
}, isa => InstanceOf['Renard::Yarn::Graphene::Matrix'];

1;
