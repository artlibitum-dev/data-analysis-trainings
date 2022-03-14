select *
into sba_naice_sector_codes_description
from
	(select
		--[NAICS_Codes],
		[NAICS_Industry_Description],
		SUBSTRING([NAICS_Industry_Description], 8, 2) as LookupCode,
		LTRIM(RIGHT([NAICS_Industry_Description], CHARINDEX('-', REVERSE([NAICS_Industry_Description])) - 1)) as Sector
	from
		[dbo].[sba_industry_standards]
	where
		[NAICS_Codes] = '' and NAICS_Industry_Description like 'Sector%'
	union
		select 'Sector 31 - 33 - Manufacturing', 32, 'Manufacturing'
	union
		select 'Sector 31 - 33 - Manufacturing', 33, 'Manufacturing'
	union
		select 'Sector 44 - 45 - Retail Trade', 45, 'Retail Trade'
	union
		select 'Sector 48 - 49 - Transportation and Warehousing', 49, 'Transportation and Warehousing'
	) main