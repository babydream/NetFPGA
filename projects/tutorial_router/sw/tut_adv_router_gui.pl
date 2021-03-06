#!/usr/bin/perl

use strict;

# Verify that we're running as root
unless ($> == 0 || $< == 0) { die "Error: $0 must be run as root" }


my $bitfile = "$ENV{'NF_ROOT'}/bitfiles/router_buffer_sizing.bit";

if ($ARGV[0] eq "--use_bin")
{
  $bitfile = $ARGV[1];
}

`/usr/local/bin/nf_download $bitfile`;
system("pushd $ENV{'NF_ROOT'}/projects/scone/sw/ ; ./scone &");
`popd`;
system("pushd $ENV{'NF_ROOT'}/lib/java/gui ; sudo ./eventcap.sh");
`popd`;
`sudo killall scone`;

exit 0;
