/*
 * $Id: Adabas.h,v 1.1 1998/04/22 17:42:33 joe Exp $
 * Copyright (c) 1994,1995,1996,1997  Tim Bunce
 *
 * You may distribute under the terms of either the GNU General Public
 * License or the Artistic License, as specified in the Perl README file.
 */

#include "mysql.h"	/* Get SQL_* defs *before* loading DBIXS.h	*/

#include <DBIXS.h>	/* from DBI. Load this after mysql.h */

#include "dbdimp.h"

#include <dbd_xsh.h>	/* from DBI. Load this after mysql.h */

/* end of ODBC.h */
