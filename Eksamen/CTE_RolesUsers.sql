/*
Select roles related to a user
UNION to privileges              
using views                      
*/
USE MXMC_db;
WITH RoleTable (Id, RoleID, RoleName, RoleDescription)
	AS (
        SELECT a.mcMSKEY, a.mcMSKEYVALUE AS 'RoleID', b.aValue AS 'RoleName', c.aValue AS 'Description'
            FROM idmv_entry_simple AS a WITH (nolock)
            LEFT OUTER JOIN idmv_value_basic_active AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.AttrName = 'DISPLAYNAME' OR b.Attr_ID IS NULL )  -- 276
            LEFT OUTER JOIN idmv_value_basic_active AS c WITH (nolock) ON c.MSKEY = a.mcMSKEY AND (c.AttrName = 'DESCRIPTION' OR c.Attr_ID IS NULL )  -- 317
            WHERE a.mcEntryType = 'MX_ROLE'
                AND mcIdStore = 1
    ),
    
    PrivilegesTable (Id, PrivID, PrivName, PrivDescription, RepositoryId)
	AS (
        SELECT a.mcMSKEY, a.mcMSKEYVALUE AS 'PrivID', b.aValue AS 'PrivName', c.aValue AS 'PrivDescription', d.aValue AS 'RepositoryId'
            FROM idmv_entry_simple AS a WITH (nolock)
            LEFT OUTER JOIN idmv_value_basic_active AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.AttrName = 'DISPLAYNAME' OR b.Attr_ID IS NULL )       --276
            LEFT OUTER JOIN idmv_value_basic_active AS c WITH (nolock) ON c.MSKEY = a.mcMSKEY AND (c.AttrName = 'DESCRIPTION' OR c.Attr_ID IS NULL )       --317
            LEFT OUTER JOIN idmv_value_basic_active AS d WITH (nolock) ON d.MSKEY = a.mcMSKEY AND (d.AttrName = 'MX_REPOSITORYNAME' OR d.Attr_ID IS NULL ) --289
            WHERE a.mcEntryType = 'MX_PRIVILEGE'
                AND mcIdStore = 1
    ),    

    UseridTable (Id, GlobalID, ActiveEmpNo, DisplayName, CC, email, [Status], ValidFrom, ValidTo, Department, OrgUnit, CostCenter, JobKey, JobText, IsManager, SNC, ManagerId )
	AS (
    SELECT a.mcMSKEY, a.mcMSKEYVALUE AS 'GlobalID', b.aValue AS 'ActiveEmpNo', 
            COALESCE(c.aValue, '') AS 'DisplayName', COALESCE(d.aValue, '') AS 'CC', COALESCE(e.aValue, '') AS 'email',
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
            AND f.[aValue] in ( '3', 'A', 'D')
            AND a.MCIDSTORE = 1
    ),

    RoleRoleTable (RoleFromId, RoleToId)
    AS (
        SELECT CAST(mcThisMSKEY AS nvarchar), CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 10  -- Role
                AND mcOtherEntryType = 10  -- Role
    ),
    PrivRoleTable (PrivId, RoleId)
    AS (
        SELECT  CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 9  -- Privilege
                AND mcOtherEntryType = 10  -- Role
    ),
    UserPrivTable (UserId, PrivId)
    AS (
        SELECT CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 7  -- Person
                AND mcOtherEntryType = 9  -- Privilege
    ),
    UserRoleTable (UserId, RoleId)
    AS (
        SELECT CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 7  -- Person
                AND mcOtherEntryType = 10  -- Role
    )

SELECT u.GlobalID, u.DisplayName, u.CC, r.RoleID AS 'Role/PrivID',
    COALESCE(r.RoleName, '') AS 'Name', '' AS Description, '' AS 'Repository'
    FROM UserIdTable AS u
    JOIN UserRoleTable AS ur ON ur.UserId = u.Id
    JOIN RoleTable AS r ON r.Id = ur.RoleId
    WHERE u.GlobalID = 'xxxxx'
UNION ALL
SELECT u.GlobalID, u.DisplayName, u.CC, p.PrivID AS 'Role/PrivID', 
    COALESCE(p.PrivName, '') AS 'Name', COALESCE(p.PrivDescription, '') AS 'Description', COALESCE(p.RepositoryId, '') AS 'Repository'
    FROM UserIdTable AS u
    JOIN UserPrivTable AS up ON up.UserId = u.Id
    JOIN PrivilegesTable AS p ON p.Id = up.PrivId
    WHERE u.GlobalID = 'xxxxx'
    ORDER BY u.GlobalID, [Role/PrivID]