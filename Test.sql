Create Database Test
go
Alter database Test Set Trustworthy on
go

Use Test
go

create assembly AssKRNCoordinationConversion  from 'E:\krnAss_CoordinationConversion.dll' WITH PERMISSION_SET = UNSAFE
go

Create Function FNGCS2UTM(@latitude as float, @longitude as float)
returns TABLE
(
	SourceCoordSys nvarchar(max),
	SourceZone int,
	SourceEasting float,
	SourceNorthing float,

	DestinationCoordSys nvarchar(max),
	DestinationZone int,
	DestinationEasting float,
	DestinationNorthing float,

	Result nvarchar(max)
)
AS
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGCS2UTM
go

Create Function FNGCS2Lambert(@latitude as float, @longitude as float, @centralMeridian as float, @parallel1 as float, @paralell2 as float, @originLatitude as float)
returns TABLE
(
	SourceCoordSys nvarchar(max),
	SourceZone int,
	SourceEasting float,
	SourceNorthing float,

	DestinationCoordSys nvarchar(max),
	DestinationZone int,
	DestinationEasting float,
	DestinationNorthing float,

	Result nvarchar(max)
)
AS
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGCS2Lambert
go

Create Function FNUTM2GCS(@utmZone int,@utmX as float, @utmY as float)
returns TABLE
(
	SourceCoordSys nvarchar(max),
	SourceZone int,
	SourceEasting float,
	SourceNorthing float,

	DestinationCoordSys nvarchar(max),
	DestinationZone int,
	DestinationEasting float,
	DestinationNorthing float,

	Result nvarchar(max)
)
AS
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNUTM2GCS
go

Create Function FNLambert2GCS(@lambertX as float, @lambertY as float, @centralMeridian as float, @parallel1 as float, @paralell2 as float, @originLatitude as float, @falseEasting as float, @falseNorthing as float)
returns TABLE
(
	SourceCoordSys nvarchar(max),
	SourceZone int,
	SourceEasting float,
	SourceNorthing float,

	DestinationCoordSys nvarchar(max),
	DestinationZone int,
	DestinationEasting float,
	DestinationNorthing float,

	Result nvarchar(max)
)
AS
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNLambert2GCS
go

Create Function FNGetWKT_GCS2Lambert(@wkt as nvarchar(max), @centralMeridian as float, @parallel1 as float, @paralell2 as float, @originLatitude as float)
returns nvarchar(max)
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGetWKT_GCS2Lambert
go

Create Function FNGetWKT_Lambert2GCS(@wkt as nvarchar(max), @centralMeridian as float, @parallel1 as float, @paralell2 as float, @originLatitude as float, @falseEasting as float, @falseNorthing as float)
returns nvarchar(max)
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGetWKT_Lambert2GCS
go

Create Function FNGetWKT_GCS2UTM(@wkt as nvarchar(max))
returns nvarchar(max)
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGetWKT_GCS2UTM
go

Create Function FNGetWKT_UTM2GCS(@wkt as nvarchar(max), @zone as tinyint)
returns nvarchar(max)
EXTERNAL NAME AssKRNCoordinationConversion.UserDefinedFunctions.FNGetWKT_UTM2GCS
go




--Create a sample table 
Create Table tbCustomers
(
	Id int,
	OGIS_Geometry geometry 
)

go

--Populate table with some records
insert into tbCustomers Select 1,geometry::STGeomFromText('POINT (342134.759363417 2239454.49064219)',1)
insert into tbCustomers Select 2,geometry::STGeomFromText('POINT (211085.407198765 4234901.18225946)',1)
insert into tbCustomers Select 3,geometry::STGeomFromText('POINT (454244.611898433 3246202.36025059)',1)
insert into tbCustomers Select 4,geometry::STGeomFromText('POINT (229844.922700829 2310567.12370018)',1)
insert into tbCustomers Select 5,geometry::STGeomFromText('POINT (120771.004881722 1311772.79549512)',1)

insert into tbCustomers Select 6,geometry::STGeomFromText('POINT (57.7593 31.64219)',1)
insert into tbCustomers Select 7,geometry::STGeomFromText('POINT (57.4071 31.1822)',1)
insert into tbCustomers Select 8,geometry::STGeomFromText('POINT (57.6198 32.025)',1)
insert into tbCustomers Select 9,geometry::STGeomFromText('POINT (57.0829 30.123)',1)
insert into tbCustomers Select 10,geometry::STGeomFromText('POINT (56.88172 31.512)',1)

insert into tbCustomers Select 11,geometry::STGeomFromText('POINT (568011.628659741 738015.159138196)',1)
insert into tbCustomers Select 12,geometry::STGeomFromText('POINT (555331.682255064 832250.788601288)',1)
insert into tbCustomers Select 13,geometry::STGeomFromText('POINT (463080.245930281 533645.89524065)',1)
insert into tbCustomers Select 14,geometry::STGeomFromText('POINT (713434.420377885 332734.605265292)',1)
insert into tbCustomers Select 15,geometry::STGeomFromText('POINT (681841.279729094 533855.17089579)',1)

select t.*,L.* from tbCustomers t cross apply dbo.FNUTM2GCS(40,OGIS_Geometry.STX,OGIS_Geometry.STY) L Where Id<=5
select t.*,L.* from tbCustomers t cross apply dbo.FNGCS2UTM(OGIS_Geometry.STY,OGIS_Geometry.STX) L Where Id<=10 And Id>5
select t.*,L.* from tbCustomers t cross apply dbo.FNGCS2Lambert(OGIS_Geometry.STY,OGIS_Geometry.STX,54.0,30.0,36.0,24.0) L Where Id<=10 And Id>5
select t.*,L.* from tbCustomers t cross apply dbo.FNLambert2GCS(OGIS_Geometry.STX,OGIS_Geometry.STY,54.0,30.0,36.0,24.0,0,0) L where Id>=11 

select *,OGIS_Geometry.STAsText() Origin_WKT_UTM_40N,dbo.FNGetWKT_UTM2GCS(OGIS_Geometry.STAsText(),40) Converted_WKT_GCS from tbCustomers Where Id<=5
select *,OGIS_Geometry.STAsText() Origin_WKT_GCS,dbo.FNGetWKT_GCS2UTM(OGIS_Geometry.STAsText()) Converted_WKT_UTM from tbCustomers Where Id<=10 And Id>5
select *,OGIS_Geometry.STAsText() Origin_WKT_GCS,dbo.FNGetWKT_GCS2Lambert(OGIS_Geometry.STAsText(),54,30,36,24) Converted_WKT_Lambert from tbCustomers Where Id<=10 And Id>5
select *,OGIS_Geometry.STAsText() Origin_WKT_Lambert,dbo.FNGetWKT_Lambert2GCS(OGIS_Geometry.STAsText(),54,30,36,24,0,0) Converted_WKT_GCS from tbCustomers Where Id>10
