/*
List users and find attributes with sub-selects
*/
USE MXMC_db;
GO
set statistics time on;
WITH UseridTable ( GlobalID, ActiveEmpNo, DisplayName, CC, email, [Status], ValidFrom, ValidTo, Department, OrgUnit, CostCenter, JobKey, JobText, IsManager, SNC, ManagerId )
	AS (
	SELECT a.mcMSKEYVALUE AS 'GlobalID'
			,(SELECT b.aValue
				FROM idmv_value_basic_active AS b with (nolock) 
				WHERE a.mcMSKEY = b.MSKEY and b.AttrName = 'CUS_GF_ACTIVE_EMPLOYEE_NUMBER') AS 'ActiveEmpNo'
			,(SELECT c.aValue 
				FROM idmv_value_basic_active AS c with (nolock) 
				WHERE a.mcMSKEY = c.MSKEY and c.AttrName = 'DISPLAYNAME') AS 'DisplayName'
			,(SELECT d.aValue 
				FROM idmv_value_basic_active AS d with (nolock) 
				WHERE a.mcMSKEY = d.MSKEY and d.AttrName = 'MX_FS_COMPANY_CODE_ID') AS 'CC'
			,(SELECT e.aValue
				FROM idmv_value_basic_active AS e with (nolock) 
				WHERE a.mcMSKEY = e.MSKEY and e.AttrName = 'MX_MAIL_PRIMARY') AS 'email'
			,(SELECT f.aValue 
				FROM idmv_value_basic_active AS f with (nolock) 
				WHERE a.mcMSKEY = f.MSKEY and f.AttrName = 'MX_FS_EMPLOYMENT_STATUS_ID') AS 'Status'
			,(SELECT g.aValue 
				FROM idmv_value_basic_active AS g with (nolock) 
				WHERE a.mcMSKEY = g.MSKEY and g.AttrName = 'MX_VALIDFROM') AS 'ValidFrom'
			,(SELECT h.aValue 
				FROM idmv_value_basic_active AS h with (nolock) 
				WHERE a.mcMSKEY = h.MSKEY and h.AttrName = 'MX_VALIDTO') AS 'ValidTo'
			,(SELECT i.aValue 
				FROM idmv_value_basic_active AS i with (nolock) 
				WHERE a.mcMSKEY = i.MSKEY and i.AttrName = 'MX_DEPARTMENT') AS 'Department'
			,(SELECT j.aValue 
				FROM idmv_value_basic_active AS j with (nolock) 
				WHERE a.mcMSKEY = j.MSKEY and j.AttrName = 'MX_FS_ORGANIZATIONAL_UNIT_ID') AS 'OrgUnit'
			,(SELECT k.aValue 
				FROM idmv_value_basic_active AS k with (nolock) 
				WHERE a.mcMSKEY = k.MSKEY and k.AttrName = 'MX_COSTCENTER') AS 'CostCenter'
			,(SELECT l.aValue 
				FROM idmv_value_basic_active AS l with (nolock) 
				WHERE a.mcMSKEY = l.MSKEY and l.AttrName = 'MX_FS_JOB_ID') AS 'JobKey'
			,(SELECT m.aValue 
				FROM idmv_value_basic_active AS m with (nolock) 
				WHERE a.mcMSKEY = m.MSKEY and m.AttrName = 'MX_FS_JOB') AS 'JobText'
			,(SELECT n.aValue 
				FROM idmv_value_basic_active AS n with (nolock) 
				WHERE a.mcMSKEY = n.MSKEY and n.AttrName = 'MX_FS_PERNR_IS_MANAGER') AS 'Manager'
			,(SELECT o.aValue 
				FROM idmv_value_basic_active AS o with (nolock) 
				WHERE a.mcMSKEY = o.MSKEY and o.AttrName = 'MX_SNC_NAME') AS 'SNC'	
            ,(SELECT p.aValue 
			FROM idmv_value_basic_active AS p with (nolock) 
				WHERE a.mcMSKEY = p.MSKEY and p.AttrName = 'MX_FS_PERSONNEL_NUMBER_OF_MANAGER') AS 'ManagerId'	    
		FROM idmv_entry_simple AS a with (nolock)
		WHERE a.mcEntryType = 'MX_PERSON'
			AND a.MCIDSTORE = 1
	 )

SELECT GlobalID AS 'GlobalID', CAST(ActiveEmpNo AS int) AS 'ActiveEmpNo', COALESCE(DisplayName,'') AS 'Name', COALESCE(CC,'') AS 'CC', COALESCE(email,'') AS 'email', COALESCE([Status],'') AS 'Status',		COALESCE(ValidFrom,'') AS 'ValidFrom', COALESCE(ValidTo,'') AS 'ValidTo',		COALESCE(Department,'') AS 'Department', COALESCE(OrgUnit,'') AS 'OrgUnit', COALESCE(CostCenter,'') AS 'CostCenter',		COALESCE(JobKey,'') AS 'JobKey', COALESCE(JobText,'') AS 'JobText', COALESCE(IsManager,'') AS 'IsManager',		COALESCE(SNC,'') AS 'SNC',		COALESCE(ManagerId,'') AS 'ManagerId'
	FROM UseridTable
    WHERE [Status] IN ('3', 'A', 'D')				-- Only active users
      AND CC = 'GBJ'
      AND JobKey = '50129808'
      AND GlobalID LIKE ('%0%')
	ORDER BY CONVERT(Int, GlobalID);
set statistics time off;    