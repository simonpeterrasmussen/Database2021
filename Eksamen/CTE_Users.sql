/*
List users and find attributes with join
Using predefined views                  
*/
USE MXMC_db;
set statistics time on;
WITH UseridTable ( GlobalID, ActiveEmpNo, DisplayName, CC, email, [Status], ValidFrom, ValidTo, Department, OrgUnit, CostCenter, JobKey, JobText, IsManager, SNC, ManagerId )
	AS (
  SELECT a.mcMSKEYVALUE AS 'GlobalID',
          CAST(b.aValue AS int) AS 'ActiveEmpNo', COALESCE(c.aValue, '') AS 'DisplayName', COALESCE(d.aValue, '') AS 'CC', COALESCE(e.aValue, '') AS 'email',
          COALESCE(f.aValue, '') AS 'Status', COALESCE(g.aValue, '') AS 'ValidFrom', COALESCE(h.aValue, '') AS 'ValidTo',
          COALESCE(i.aValue, '') AS 'Department', COALESCE(j.aValue, '') AS 'OrgUnit', COALESCE(k.aValue, '') AS 'CostCenter',
          COALESCE(l.aValue, '') AS 'JobKey', COALESCE(m.aValue, '') AS 'JobText', COALESCE(n.aValue, '') AS 'IsManager',
          COALESCE(o.aValue, '') AS 'SNC', COALESCE(p.aValue, '') AS 'ManagerId'
    FROM idmv_entry_simple AS a WITH (nolock)
    LEFT OUTER JOIN idmv_value_basic_active AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.AttrName = 'CUS_GF_ACTIVE_EMPLOYEE_NUMBER' OR b.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS c WITH (nolock) ON c.MSKEY = a.mcMSKEY AND (c.AttrName = 'DISPLAYNAME' OR c.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS d WITH (nolock) ON d.MSKEY = a.mcMSKEY AND (d.AttrName = 'MX_FS_COMPANY_CODE_ID' OR d.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS e WITH (nolock) ON e.MSKEY = a.mcMSKEY AND (e.AttrName = 'MX_MAIL_PRIMARY' OR e.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS f WITH (nolock) ON f.MSKEY = a.mcMSKEY AND (f.AttrName = 'MX_FS_EMPLOYMENT_STATUS_ID' OR f.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS g WITH (nolock) ON g.MSKEY = a.mcMSKEY AND (g.AttrName = 'MX_VALIDFROM' OR g.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS h WITH (nolock) ON h.MSKEY = a.mcMSKEY AND (h.AttrName = 'MX_VALIDTO' OR h.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS i WITH (nolock) ON i.MSKEY = a.mcMSKEY AND (i.AttrName = 'MX_DEPARTMENT' OR i.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS j WITH (nolock) ON j.MSKEY = a.mcMSKEY AND (j.AttrName = 'MX_FS_ORGANIZATIONAL_UNIT_ID' OR j.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS k WITH (nolock) ON k.MSKEY = a.mcMSKEY AND (k.AttrName = 'MX_COSTCENTER' OR k.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS l WITH (nolock) ON l.MSKEY = a.mcMSKEY AND (l.AttrName = 'MX_FS_JOB_ID' OR l.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS m WITH (nolock) ON m.MSKEY = a.mcMSKEY AND (m.AttrName = 'MX_FS_JOB' OR m.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS n WITH (nolock) ON n.MSKEY = a.mcMSKEY AND (n.AttrName = 'MX_FS_PERNR_IS_MANAGER' OR n.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS o WITH (nolock) ON o.MSKEY = a.mcMSKEY AND (o.AttrName = 'MX_SNC_NAME' OR o.Attr_ID IS NULL )
    LEFT OUTER JOIN idmv_value_basic_active AS p WITH (nolock) ON p.MSKEY = a.mcMSKEY AND (p.AttrName = 'MX_FS_PERSONNEL_NUMBER_OF_MANAGER' OR p.Attr_ID IS NULL )
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