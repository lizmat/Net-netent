[![Actions Status](https://github.com/lizmat/Net-netent/workflows/test/badge.svg)](https://github.com/lizmat/Net-netent/actions)

NAME
====

Raku port of Perl's Net::netent module

SYNOPSIS
========

    use Net::netent;

    my $n = getnetbyname("loopback")       or die "bad net";
    printf "%s is %08X\n", $n.name, $n.net;

    use Net::netent qw(:FIELDS);
    getnetbyname("loopback")               or die "bad net";
    printf "%s is %08X\n", $n_name, $n_net;

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `Net::netent` module as closely as possible in the Raku Programming Language.

This module's exports `getnetbyname`, `getnetbyaddrd`, and `getnetent` functions that return `Netr::netent` objects. This object has methods that return the similarly named structure field name from the C's netent structure from netdb.h, stripped of their leading "n_" parts, namely name, aliases, addrtype and net.

You may also import all the structure fields directly into your namespace as regular variables using the :FIELDS import tag. Access these fields as variables named with a preceding n_ in front their method names. Thus, $net_obj.name corresponds to $n_name if you import the fields.

The `getnet` function is a simple front-end that forwards a numeric argument to `getnetbyaddr` and the rest to `getnetbyname`.

PORTING CAVEATS
===============

This module depends on the availability of POSIX semantics. This is generally not available on Windows, so this module will probably not work on Windows.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Net-netent . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

