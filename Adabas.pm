# $Id: Adabas.pm,v 1.1 1998/04/22 17:42:33 joe Exp $
#
# Copyright (c) 1994,1995,1996  Tim Bunce
# portions Copyright (c) 1997  Thomas K. Wenrich
# portions Copyright (c) 1997  Jeff Urlwin
#
# You may distribute under the terms of either the GNU General Public
# License or the Artistic License, as specified in the Perl README file.

require 5.004;
{
    package DBD::Adabas;

    use DBI ();
    use DynaLoader ();

    @ISA = qw(DynaLoader);

    $VERSION = '0.16';
    my $Revision = substr(q$Revision: 1.1 $, 10);

    require_version DBI 0.86;

    bootstrap DBD::Adabas $VERSION;

    $err = 0;		# holds error code   for DBI::err
    $errstr = "";	# holds error string for DBI::errstr
    $sqlstate = "00000";
    $drh = undef;	# holds driver handle once initialised

    sub driver{
	return $drh if $drh;
	my($class, $attr) = @_;

	$class .= "::dr";

	# not a 'my' since we use it above to prevent multiple drivers

	$drh = DBI::_new_drh($class, {
	    'Name' => 'Adabas',
	    'Version' => $VERSION,
	    'Err'    => \$DBD::Adabas::err,
	    'Errstr' => \$DBD::Adabas::errstr,
	    'State' => \$DBD::Adabas::sqlstate,
	    'Attribution' => 'Adabas DBD, based on ODBC DBD by Jeff Urlwin',
	    });

	$drh;
    }

    1;
}


{   package DBD::Adabas::dr; # ====== DRIVER ======
    use strict;

    sub connect {
	my $drh = shift;
	my($dbname, $user, $auth)= @_;

	# create a 'blank' dbh
	my $this = DBI::_new_dbh($drh, {
	    'Name' => $dbname,
	    'USER' => $user, 
	    'CURRENT_USER' => $user,
	    });

	# Call ODBC logon func in Adabas.xs file
	# and populate internal handle data.

	DBD::Adabas::db::_login($this, $dbname, $user, $auth) or return undef;

	$this;
    }

}


{   package DBD::Adabas::db; # ====== DATABASE ======
    use strict;

    sub prepare {
	my($dbh, $statement, @attribs)= @_;

	# create a 'blank' dbh
	my $sth = DBI::_new_sth($dbh, {
	    'Statement' => $statement,
	    });

	# Call Adabas OCI oparse func in Adabas.xs file.
	# (This will actually also call oopen for you.)
	# and populate internal handle data.

	DBD::Adabas::st::_prepare($sth, $statement, @attribs)
	    or return undef;

	$sth;
    }

    sub tables {
	my($dbh) = @_;		# XXX add qualification

	# create a "blank" statement handle
	my $sth = DBI::_new_sth($dbh, { 'Statement' => "SQLTables" });

	# XXX use qaulification(s) (qual, schema, etc?) here...
	DBD::Adabas::st::_tables($dbh,$sth, "")
		or return undef;

	$sth;
    }

    sub quote {
        my($self, $str) = @_;
        if (!defined($str)) {
	    return 'NULL';
	}
	if ($str =~ /\0/) {
	    return "x'" . unpack("H*", $str) . "'";
	}
	$str =~ s/\'/\'\'/g;
	"'$str'";
    }
}


{   package DBD::Adabas::st; # ====== STATEMENT ======
    use strict;

}
1;
__END__
