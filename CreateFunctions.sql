--Change the path according to location of krnAss_CoordinationConversion.dll file on your computer
--Here I suppose you copy it on E partition root and you have accecc to this file

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
