/****** Script for SelectTopNRows command from SSMS  ******/

-- what is the summary of all approved PPP loans ---
--SELECT 
--	year(DateApproved) as year_Approve,
--	count(distinct OriginatingLender) as OriginatingLender,
--	COUNT(LoanNumber) as Number_of_Approve,
--	SUM(InitialApprovalAmount) as Approved_Amount,
--	AVG(InitialApprovalAmount) as Average_Loan_Size
--FROM sba_public_data
--group by year(DateApproved)

--- Top 15 Originating Landers by loan count, total amount and average in 2020 and 2021
--SELECT Top 15
--	OriginatingLender,
--	COUNT(LoanNumber) as Number_of_Approve,
--	SUM(InitialApprovalAmount) as Approved_Amount,
--	AVG(InitialApprovalAmount) as Average_Loan_Size
--FROM sba_public_data
--where year(DateApproved) = 2021
--group by OriginatingLender
--order by 3 desc

--- Top 20 Industries that receive the PPP loan in 2020 and 2021
--;with cte as
--(
--	SELECT Top 20
--		d.Sector as Sector,
--		COUNT(LoanNumber) as Number_of_Approve,
--		SUM(InitialApprovalAmount) as Approved_Amount,
--		AVG(InitialApprovalAmount) as Average_Loan_Size
--	FROM sba_public_data as p
--		inner join sba_naice_sector_codes_description as d 
--		on left(p.NAICSCode, 2) = d.LookupCode

--	where year(DateApproved) = 2020
--	group by d.Sector, YEAR(DateApproved)
--) 

--select 
--	Sector 
--	, Number_of_Approve 
--	, FORMAT(Approved_Amount, '#,#') as Approved_Amount
--	, FORMAT(Average_Loan_Size, '#,#') as Average_Loan_Size
--	, FORMAT(Approved_Amount / sum(Approved_Amount) over() AS DECIMAL(5,2) * 100, '0.0') as Percent_by_amount
--from cte
--order by cte.Approved_Amount desc

--How much of the PPP Loans of 2021 have been fully forgiven
--SELECT 
--	COUNT(LoanNumber) as Number_of_Approve,
--	SUM(CurrentApprovalAmount) as Current_Approved_Amount,
--	AVG(CurrentApprovalAmount) as Current_Average_Loan_Size,
--	SUM(ForgivenessAmount) as Forgiveness_Amount,
--	SUM(ForgivenessAmount) / SUM(CurrentApprovalAmount) as Forgiveness_percent
--FROM sba_public_data
--where year(DateApproved) = 2021
--order by Current_Average_Loan_Size desc

--- Year, Month with higest PPP loans approved

select
	YEAR(pd.dateapproved) as year_approved
	, MONTH(pd.dateapproved) as month_approved
	, COUNT(pd.loannumber) as loan_count
	, FORMAT(SUM(pd.InitialApprovalAmount), '#,#') as Approved_Amount
	, FORMAT(AVG(pd.InitialApprovalAmount), '#,#') as Average_Loan_Size
from sba_public_data as pd
group by 
	YEAR(pd.dateapproved)
	, MONTH(pd.dateapproved)
order by 
	YEAR(pd.dateapproved) desc 
	, SUM(pd.InitialApprovalAmount) desc