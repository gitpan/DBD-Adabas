/*
 * $Id: Adabas.h,v 1.2 1998/07/14 10:55:08 joe Exp $
 * Copyright (c) 1994,1995,1996,1997  Tim Bunce
 *
 * You may distribute under the terms of either the GNU General Public
 * License or the Artistic License, as specified in the Perl README file.
 */

#include "mysql.h"	/* Get SQL_* defs *before* loading DBIXS.h	*/

#include <DBIXS.h>	/* from DBI. Load this after mysql.h */

#include "dbdimp.h"

#include <dbd_xsh.h>	/* from DBI. Load this after mysql.h */

SV      *adabas_get_info _((SV *dbh, int ftype));
int      adabas_get_type_info _((SV *dbh, SV *sth, int ftype));
SV	*adabas_col_attributes _((SV *sth, int colno, int desctype));
int	 adabas_describe_col _((SV *sth, int colno,
	    SQLCHAR *ColumnName, SQLSMALLINT BufferLength, SQLSMALLINT *NameLength,
	    SQLSMALLINT *DataType, SQLUINTEGER *ColumnSize,
	    SQLSMALLINT *DecimalDigits, SQLSMALLINT *Nullable));
int	 adabas_db_columns _((SV *dbh, SV *sth,
	    char *catalog, char *schema, char *table, char *column));

/* end of Adabas.h */

