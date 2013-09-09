MySQL-TSDNS
===========
A TSDNS-server for teamspeak 3, that uses MySQL for configuration.  
For more information how it works, look at [**Configuration**](#configuration).

Requirements
------------
 - [nodejs](http://nodejs.org/)
 - [npm](https://npmjs.org)


Installation
------------
 1. Download the latest release from the [release-page](https://github.com/zyberWare/mysql-tsdns/releases).
 2. Run `npm install` to install the dependencies.
 3. Edit the `config.json`-file, as your needs.
 4. Import the `init.sql` into your database (structure + testdata). Ensure that you selected a target scheme with `use myDatabase` first.
 5. Change the settings in the db, as your needs (see [**Configuration**](#configuration) for more).
 6. Run `./mysql_tsdns_startscript start` to start the MySQL-TSDNS-server and your are ready. :D

### From source
 1. Download the git-repository.
 2. Run `npm install` to install the dependencies.
 3. Copy the `config.dist.json`-file to `config.json`.
 4. Proceed with installation-steps 3-6 from above.

Configuration
-------------
MySQL-TSDNS stores all data in the db (name would be silly otherwise).  
As a domain is requested, MySQL-TSDNS first read all available tables to look the teamspeak-servers up from the `serverTables`-Table, then it goes throw every table and searches for the requested domain. If it found something, it gives back the destination and closes the request. If nothing is found, it tries to get a default-server from the `serverDefault`-table, if one is specified and active.

If nothing is found again, MySQL-TSDNS returns `404` and closes the request also.  
The teamspeak-client will show a "Server not found" in this case.

An example setup is shipped with the import of the `init.sql`-file, which will fit for the most usages (just add more servers to the `basic`-table).

### A note to the `additionalColumns`-Column in the `serverTables`-table
This field is used, to tell the programm, that there are special columns in the specified serverTable.
At the moment, the only usable special column is `lastLookup`, which should be an integer as type.
If you specified this column, MySQL-TSDNS will save a timestamp in this field, everytime the domain is requested.

License
-------
This software is licensed under the [Mozilla Public License v. 2.0](http://mozilla.org/MPL/2.0/). For more information, read the file `LICENSE`.