USE MXMC_db;
GO
/*
List users and find attributes with joins 
Direct on tables, i.e. no view            
*/
set statistics time on;
WITH UseridTable (GlobalID, ActiveEmpNo, DisplayName, CC, email, [Status], ValidFrom, ValidTo, Department, OrgUnit, CostCenter, JobKey, JobText, IsManager, SNC, ManagerId )
	AS (
  SELECT CAST(a.mcMSKEYVALUE AS nvarchar) AS 'GlobalID', b.aValue AS 'ActiveEmpNo', 
          COALESCE(c.aValue, '') AS 'DisplayName', COALESCE(d.aValue, '') AS 'CC', COALESCE(e.aValue, '') AS 'email',
          COALESCE(f.aValue, '') AS 'Status', COALESCE(g.aValue, '') AS 'ValidFrom', COALESCE(h.aValue, '') AS 'ValidTo',
          COALESCE(i.aValue, '') AS 'Department', COALESCE(j.aValue, '') AS 'OrgUnit', COALESCE(k.aValue, '') AS 'CostCenter',
          COALESCE(l.aValue, '') AS 'JobKey', COALESCE(m.aValue, '') AS 'JobText', COALESCE(n.aValue, '') AS 'IsManager',
          COALESCE(o.aValue, '') AS 'SNC', COALESCE(p.aValue, '') AS 'ManagerId'
    FROM mxi_entry AS a WITH (nolock)
    LEFT OUTER JOIN MXI_VALUES AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.Attr_ID = 825 OR b.Attr_ID IS NULL )  -- 'CUS_GF_ACTIVE_EMPLOYEE_NUMBER'
    LEFT OUTER JOIN MXI_VALUES AS c WITH (nolock) ON c.MSKEY = a.mcMSKEY AND (c.Attr_ID = 276 OR c.Attr_ID IS NULL )  -- 'DISPLAYNAME'
    LEFT OUTER JOIN MXI_VALUES AS d WITH (nolock) ON d.MSKEY = a.mcMSKEY AND (d.Attr_ID = 350 OR d.Attr_ID IS NULL )  -- 'MX_FS_COMPANY_CODE_ID' 
    LEFT OUTER JOIN MXI_VALUES AS e WITH (nolock) ON e.MSKEY = a.mcMSKEY AND (e.Attr_ID = 227 OR e.Attr_ID IS NULL )  -- 'MX_MAIL_PRIMARY'
    LEFT OUTER JOIN MXI_VALUES AS f WITH (nolock) ON f.MSKEY = a.mcMSKEY AND (f.Attr_ID = 241 OR f.Attr_ID IS NULL )  -- 'MX_FS_EMPLOYMENT_STATUS_ID'
    LEFT OUTER JOIN MXI_VALUES AS g WITH (nolock) ON g.MSKEY = a.mcMSKEY AND (g.Attr_ID = 392 OR g.Attr_ID IS NULL )  -- 'MX_VALIDFROM' 
    LEFT OUTER JOIN MXI_VALUES AS h WITH (nolock) ON h.MSKEY = a.mcMSKEY AND (h.Attr_ID = 131 OR h.Attr_ID IS NULL )  -- 'MX_VALIDTO'  
    LEFT OUTER JOIN MXI_VALUES AS i WITH (nolock) ON i.MSKEY = a.mcMSKEY AND (i.Attr_ID = 163 OR i.Attr_ID IS NULL )  -- 'MX_DEPARTMENT' 
    LEFT OUTER JOIN MXI_VALUES AS j WITH (nolock) ON j.MSKEY = a.mcMSKEY AND (j.Attr_ID = 242 OR j.Attr_ID IS NULL )  -- 'MX_FS_ORGANIZATIONAL_UNIT_ID'
    LEFT OUTER JOIN MXI_VALUES AS k WITH (nolock) ON k.MSKEY = a.mcMSKEY AND (k.Attr_ID = 171 OR k.Attr_ID IS NULL )  -- 'MX_COSTCENTER'
    LEFT OUTER JOIN MXI_VALUES AS l WITH (nolock) ON l.MSKEY = a.mcMSKEY AND (l.Attr_ID = 272 OR l.Attr_ID IS NULL )  -- 'MX_FS_JOB_ID' 
    LEFT OUTER JOIN MXI_VALUES AS m WITH (nolock) ON m.MSKEY = a.mcMSKEY AND (m.Attr_ID = 341 OR m.Attr_ID IS NULL )  -- 'MX_FS_JOB'
    LEFT OUTER JOIN MXI_VALUES AS n WITH (nolock) ON n.MSKEY = a.mcMSKEY AND (n.Attr_ID =  81 OR n.Attr_ID IS NULL )  -- 'MX_FS_PERNR_IS_MANAGER'
    LEFT OUTER JOIN MXI_VALUES AS o WITH (nolock) ON o.MSKEY = a.mcMSKEY AND (o.Attr_ID = 335 OR o.Attr_ID IS NULL )  -- 'MX_SNC_NAME'
    LEFT OUTER JOIN MXI_VALUES AS p WITH (nolock) ON p.MSKEY = a.mcMSKEY AND (p.Attr_ID = 175 OR p.Attr_ID IS NULL )  -- 'MX_FS_PERSONNEL_NUMBER_OF_MANAGER'
    WHERE a.mcEntryType = 'MX_PERSON'
      AND a.MCIDSTORE = 1
  )

SELECT * FROM UseridTable
    WHERE [Status] IN ('3', 'A', 'D')				-- Only active users
      AND CC = 'GBJ'
      AND JobKey = '50129808'
      AND GlobalID LIKE ('%0%')
	ORDER BY GlobalID;
set statistics time off;