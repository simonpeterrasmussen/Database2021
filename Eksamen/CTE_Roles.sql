USE MXMC_db;
GO

/*
Select roles.    
Select privileges 
Select links      
*/

WITH RoleTable (Id, RoleID, RoleName)
	AS (
        SELECT a.mcMSKEY, a.mcMSKEYVALUE AS 'RoleID', b.aValue AS 'RoleName'
            FROM idmv_entry_simple AS a WITH (nolock)
            LEFT OUTER JOIN idmv_value_basic_active AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.AttrName = 'DISPLAYNAME' OR b.Attr_ID IS NULL )
            WHERE a.mcEntryType = 'MX_ROLE'
                AND mcIdStore = 1
    ),
    PrivilegesTable (Id, PrivID, PrivName, PrivDescription, RepositoryId)
	AS (
        SELECT a.mcMSKEY, a.mcMSKEYVALUE AS 'PrivID', b.aValue AS 'PrivName', c.aValue AS 'PrivDescription', d.aValue AS 'RepositoryId'
            FROM idmv_entry_simple AS a WITH (nolock)
            LEFT OUTER JOIN idmv_value_basic_active AS b WITH (nolock) ON b.MSKEY = a.mcMSKEY AND (b.AttrName = 'DISPLAYNAME' OR b.Attr_ID IS NULL )
            LEFT OUTER JOIN idmv_value_basic_active AS c WITH (nolock) ON c.MSKEY = a.mcMSKEY AND (c.AttrName = 'DISPLAYNAME' OR c.Attr_ID IS NULL )
            LEFT OUTER JOIN idmv_value_basic_active AS d WITH (nolock) ON d.MSKEY = a.mcMSKEY AND (d.AttrName = 'DISPLAYNAME' OR d.Attr_ID IS NULL )
            WHERE a.mcEntryType = 'MX_PRIVILEGE'
                AND mcIdStore = 1
    ),
    RoleRoleTable (RoleFromId, RoleToId)
    AS (
        SELECT CAST(mcThisMSKEY AS nvarchar), CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 10
                AND mcOtherEntryType = 10
    ),
    PrivRoleTable (PrivId, RoleId)
    AS (
        SELECT  CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 9
                AND mcOtherEntryType = 10
    ),
    UserPrivTable (UserId, PrivId)
    AS (
        SELECT CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 7
                AND mcOtherEntryType = 9        
    ),
    UserRoleTable (UserId, RoleId)
    AS (
        SELECT  CAST(mcThisMSKEY AS nvarchar),  CAST(mcOtherMSKEY AS nvarchar)--,  mcThisEntryType, mcOtherEntryType
            FROM idmv_link_simple_active WITH (nolock)
            WHERE mcThisEntryType = 7
                AND mcOtherEntryType = 10        
    )

SELECT r.RoleID, r.RoleName, rt.RoleID, rt.RoleName
    FROM RoleTable AS r 
    JOIN RoleRoleTable AS rr ON rr.RoleToId = r.ID
    JOIN RoleTable AS rt ON rt.Id = rr.RoleFromId
    WHERE r.RoleId LIKE 'BR:GBR_L%00000000_20_GMA%'

UNION ALL

SELECT r.RoleID, r.RoleName, p.PrivID, p.PrivName
    FROM RoleTable AS r 
    JOIN PrivRoleTable AS pr ON pr.RoleId = r.ID
    JOIN PrivilegesTable AS p ON p.Id = pr.PrivId
    WHERE r.RoleId LIKE 'BR:GBR_L%00000000_20_GMA%';