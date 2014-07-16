package SOAP::WSDL::XSD::Schema;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.10');

# child elements
my %attributeGroup_of   :ATTR(:name<attributeGroup>  :default<[]>);
my %attribute_of        :ATTR(:name<attribute>       :default<[]>);
my %element_of          :ATTR(:name<element>         :default<[]>);
my %group_of            :ATTR(:name<group>           :default<[]>);
my %type_of             :ATTR(:name<type>            :default<[]>);

# attributes
my %attributeFormDefault_of :ATTR(:name<attributeFormDefault> :default<unqualified>);
my %blockDefault_of         :ATTR(:name<blockDefault>         :default<()>);
my %elementFormDefault_of   :ATTR(:name<elementFormDefault>   :default<unqualified>);
my %finalDefault_of         :ATTR(:name<finalDefault>         :default<()>);
my %version_of              :ATTR(:name<version>              :default<()>);

# id
# name
# targetNamespace inherited from Base
# xmlns

#
#  attributeFormDefault = (qualified | unqualified) : unqualified
#  blockDefault = (#all | List of (extension | restriction | substitution))  : ''
#  elementFormDefault = (qualified | unqualified) : unqualified
#  finalDefault = (#all | List of (extension | restriction | list | union))  : ''
#  id = ID
#  targetNamespace = anyURI
#  version = token
#  xml:lang = language
#
#
# alias type with all variants
# AUTOMETHOD is WAY too slow..
{
    no strict qw/refs/;
    for my $name (qw(simpleType complexType) ) {
        *{ "set_$name" } = \&set_type;
        *{ "get_$name" } = \&get_type;
        *{ "push_$name" } = \&push_type;
        *{ "find_$name" } = \&find_type;
    }
}

sub push_type {
    # use $_[n] for performance -
    # we're called on each and every type inside WSDL
    push @{ $type_of{ ident $_[0]} }, $_[1];
}

sub find_element {
    my ($self, @args) = @_;
    my @found_at = grep {
        $_->get_targetNamespace() eq $args[0] &&
#		warn $_->get_name() . " default NS:" . $_->get_xmlns()->{'#default'} . "\n";
#		$_->get_xmlns()->{'#default'} eq $args[0] &&
        $_->get_name() eq $args[1]
    }
    @{ $element_of{ ident $self } };
    return $found_at[0];
}

sub find_type {
    my ($self, @args) = @_;
    my @found_at = grep {
        $_->get_targetNamespace() eq $args[0] &&
#        $_->get_xmlns()->{'#default'} eq $args[0] &&
        $_->get_name() eq $args[1]
    }
    @{ $type_of{ ident $self } };
    return $found_at[0];
}

1;
