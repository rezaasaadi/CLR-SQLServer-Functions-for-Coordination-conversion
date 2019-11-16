# CLR-SQLServer-Functions-for-Coordination-conversion
These are some functions to convert OGC  well known text from GCS coordination to UTM/Lambert and vice versa.
To use them,First you need to have a "CLR Enabled" SQL server instance. https://docs.microsoft.com/en-us/sql/relational-databases/clr-integration/clr-integration-enabling
Second you need to make your database "Trustworthy On" to enable it accepting CLR assembly. https://docs.microsoft.com/en-us/sql/relational-databases/security/trustworthy-database-property
Third you need to add CLR assembly to your database and create functions,to do that simply login to "SQL Server Management Studio" using database owner login (for example sa) and execute the file "CreateFunction.sql"
when executing scripts get finished successfully,you have 4 tabular functions named FNGCS2UTM,FNGCS2Lambert,FNUTM2GCS,FNLambert2GCS and 4 scalar functions named FNGetWKT_GCS2Lambert,FNGetWKT_Lambert2GCS,FNGetWKT_GCS2UTM,FNGetWKT_UTM2GCS which you can use them in queries,views and stored procedures and convert coordinate conversion in database level.
There are some sample scripts in file "Test.sql" that I provided to show you how to use thes 8 functions generally
