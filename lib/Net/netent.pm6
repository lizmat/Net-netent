use v6.*;

our $n_name     is export(:FIELDS);
our @n_aliases  is export(:FIELDS);
our $n_addrtype is export(:FIELDS);
our $n_net      is export(:FIELDS);

class Net::netent:ver<0.0.3>:auth<cpan:ELIZABETH> {
    has Str $.name;
    has     @.aliases;
    has Int $.addrtype;
    has Int $.net
}

sub populate(@fields) {
    if @fields {
        Net::netent.new(
          name     => ($n_name     = @fields[0]),
          aliases  => (@n_aliases  = @fields[1]),
          addrtype => ($n_addrtype = @fields[2]),
          net      => ($n_net      = @fields[3]),
        )
    }
    else {
          $n_name     = Str;
          @n_aliases  = ();
          $n_addrtype = Int;
          $n_net      = Int;
          Nil
    }
}

my sub getnetbyname(Str() $name) is export(:DEFAULT:FIELDS) {
    use P5getnetbyname:ver<0.0.6>:auth<cpan:ELIZABETH>;
    populate(getnetbyname($name))
}

my sub getnetbyaddr(Int:D $addrtype, Int:D $net) is export(:DEFAULT:FIELDS) {
    use P5getnetbyname:ver<0.0.6>:auth<cpan:ELIZABETH>;
    populate(getnetbyaddr($addrtype,$net))
}

my sub getnetent() is export(:DEFAULT:FIELDS) {
    use P5getnetbyname:ver<0.0.6>:auth<cpan:ELIZABETH>;
    populate(getnetent)
}

my proto sub getnet(|) is export(:DEFAULT:FIELDS) {*}
my multi sub getnet(Int:D $addr) is export(:DEFAULT:FIELDS) {
    getnetbyaddr($addr)
}
my multi sub getnet(Str:D $nam) is export(:DEFAULT:FIELDS) {
    getnetbyname($nam)
}

my constant &setnetent is export(:DEFAULT:FIELDS) = do {
    use P5getnetbyname:ver<0.0.6>:auth<cpan:ELIZABETH>;
    &setnetent
}
my constant &endnetent is export(:DEFAULT:FIELDS) = do {
    use P5getnetbyname:ver<0.0.6>:auth<cpan:ELIZABETH>;
    &endnetent
}

=begin pod

=head1 NAME

Raku port of Perl 5's Net::netent module

=head1 SYNOPSIS

    use Net::netent;

    my $n = getnetbyname("loopback")       or die "bad net";
    printf "%s is %08X\n", $n.name, $n.net;

    use Net::netent qw(:FIELDS);
    getnetbyname("loopback")               or die "bad net";
    printf "%s is %08X\n", $n_name, $n_net;

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<Net::netent> module
as closely as possible in the Raku Programming Language.

This module's exports C<getnetbyname>, C<getnetbyaddrd>, and C<getnetent>
functions that return C<Netr::netent> objects. This object has methods that
return the similarly named structure field name from the C's netent structure
from netdb.h, stripped of their leading "n_" parts, namely name, aliases,
addrtype and net.

You may also import all the structure fields directly into your namespace as
regular variables using the :FIELDS import tag.  Access these fields as
variables named with a preceding n_ in front their method names. Thus,
$net_obj.name corresponds to $n_name if you import the fields.

The C<getnet> function is a simple front-end that forwards a numeric argument
to C<getnetbyaddr> and the rest to C<getnetbyname>.

=head1 PORTING CAVEATS

This module depends on the availability of POSIX semantics.  This is
generally not available on Windows, so this module will probably not work
on Windows.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Net-netent . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018,2020 Elizabeth Mattijsen

Re-imagined from Perl 5 as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
