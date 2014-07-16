package SOAP::WSDL::XSD::Annotation;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.10');

#<enumeration value="">

# id provided by Base
# name provided by Base
# annotation provided by Base

# may be defined as atomic simpleType
my %appinfo_of        :ATTR(:name<appinfo> :default<()>);

# documentation provided by Base

1;