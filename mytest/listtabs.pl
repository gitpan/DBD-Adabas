#!/usr/bin/perl -I./t

require DBI;
use DBD::Adabas::Const qw(:sql_types);
use testenv;

my (@row);

my ($dsn, $user, $pass) = soluser();

my $dbh = DBI->connect("DBI:Adabas:$dsn", $user, $pass)
    or exit(0);
# ------------------------------------------------------------

my $rows = 0;
if ($sth = $dbh->tables())
    {
    while (@row = $sth->fetchrow())
        {
		$rows++;
		print "@row\n";
        }
    $sth->finish();
    }

$dbh->disconnect();

