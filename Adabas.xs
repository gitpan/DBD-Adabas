#include "Adabas.h"

DBISTATE_DECLARE;

MODULE = DBD::Adabas    PACKAGE = DBD::Adabas

INCLUDE: Adabas.xsi

MODULE = DBD::Adabas    PACKAGE = DBD::Adabas::st

void
_tables(dbh, sth, qualifier)
	SV *	dbh
	SV *	sth
	char *	qualifier
	CODE:
	ST(0) = dbd_st_tables(dbh, sth, qualifier, "TABLE") ? &sv_yes : &sv_no;

MODULE = DBD::Adabas    PACKAGE = DBD::Adabas::st

