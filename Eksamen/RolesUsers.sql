/*
Try to see without CTE
*/
USE MXMC_db;
SELECT CAST(a.mcMSKEYVALUE AS nvarchar) AS 'GlobalID', COALESCE(c.aValue, '') AS 'DisplayName', COALESCE(d.aValue, '') AS 'CC'
        , rolea.mcMSKEYVALUE AS 'Role/PrivID', roleb.aValue AS 'Role/PrivName', COALESCE(rolec.aValue, '') AS 'Description', '' AS 'Repository'
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
    JOIN idmv_link_simple_active AS [link] WITH (nolock) ON a.mcMSKEY = link.mcThisMSKEY AND (link.mcThisEntryType = 7 AND link.mcOtherEntryType = 10)
    JOIN idmv_entry_simple AS rolea WITH (nolock) ON rolea.mcMSKEY = link.mcOtherMSKEY
    LEFT OUTER JOIN idmv_value_basic_active AS roleb WITH (nolock) ON roleb.MSKEY = rolea.mcMSKEY AND (roleb.AttrName = 'DISPLAYNAME' OR roleb.Attr_ID IS NULL )       --276
    LEFT OUTER JOIN idmv_value_basic_active AS rolec WITH (nolock) ON rolec.MSKEY = rolea.mcMSKEY AND (rolec.AttrName = 'DESCRIPTION' OR rolec.Attr_ID IS NULL )       --317
    WHERE a.mcEntryType = 'MX_PERSON'
        AND f.[aValue] in ( '3', 'A', 'D')
        AND a.MCIDSTORE = 1
        AND a.mcMSKEYVALUE = 'xxxxx'
        AND rolea.mcEntryType = 'MX_ROLE'    

UNION ALL

SELECT CAST(a.mcMSKEYVALUE AS nvarchar) AS 'GlobalID', COALESCE(c.aValue, '') AS 'DisplayName', COALESCE(d.aValue, '') AS 'CC'
        , priva.mcMSKEYVALUE AS 'Role/PrivID', privb.aValue AS 'Role/PrivName', COALESCE(privc.aValue,'') AS 'Description', COALESCE(privd.aValue, '') AS 'Repository'
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
    JOIN idmv_link_simple_active AS [link] WITH (nolock) ON a.mcMSKEY = link.mcThisMSKEY AND (link.mcThisEntryType = 7 AND link.mcOtherEntryType = 9)
    JOIN idmv_entry_simple AS priva WITH (nolock) ON priva.mcMSKEY = link.mcOtherMSKEY
    LEFT OUTER JOIN idmv_value_basic_active AS privb WITH (nolock) ON privb.MSKEY = priva.mcMSKEY AND (privb.AttrName = 'DISPLAYNAME' OR privb.Attr_ID IS NULL )       --276
    LEFT OUTER JOIN idmv_value_basic_active AS privc WITH (nolock) ON privc.MSKEY = priva.mcMSKEY AND (privc.AttrName = 'DESCRIPTION' OR privc.Attr_ID IS NULL )       --317
    LEFT OUTER JOIN idmv_value_basic_active AS privd WITH (nolock) ON privd.MSKEY = priva.mcMSKEY AND (privd.AttrName = 'MX_REPOSITORYNAME' OR privd.Attr_ID IS NULL ) --289
    WHERE a.mcEntryType = 'MX_PERSON'
        AND f.[aValue] in ( '3', 'A', 'D')
        AND a.MCIDSTORE = 1
        AND a.mcMSKEYVALUE = 'xxxxx'
        AND priva.mcEntryType = 'MX_PRIVILEGE'