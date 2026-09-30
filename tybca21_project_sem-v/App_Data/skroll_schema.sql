/*
    Skroll - database schema
    ------------------------
    This script contains only the database structure required by the application.
    It intentionally contains no user accounts, passwords, posts, comments, likes,
    or other personal/test data.

    Recommended Visual Studio 2022 setup:
    1. Add New Item -> SQL Server Database and name it skroll.mdf inside App_Data.
    2. Open a query against that database.
    3. Run this script.
*/

CREATE TABLE dbo.user_info
(
    user_id     INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_nm     NVARCHAR(50) NOT NULL UNIQUE,
    f_name      NVARCHAR(50) NOT NULL,
    l_name      NVARCHAR(50) NOT NULL,
    email       NVARCHAR(255) NOT NULL UNIQUE,
    [password]  NVARCHAR(255) NOT NULL,
    [date]      DATETIME NOT NULL CONSTRAINT DF_user_info_date DEFAULT (GETDATE()),
    b_date      DATE NULL,
    user_p      NVARCHAR(500) NULL CONSTRAINT DF_user_info_user_p DEFAULT (N'~/images/user.png'),
    user_bio    NVARCHAR(500) NULL,
    gender      NVARCHAR(20) NULL
);
GO

CREATE TABLE dbo.social_network
(
    user_id      INT NOT NULL,
    follower_id  INT NOT NULL,
    [date]       DATETIME NOT NULL CONSTRAINT DF_social_network_date DEFAULT (GETDATE()),
    CONSTRAINT PK_social_network PRIMARY KEY (user_id, follower_id)
);
GO

CREATE TABLE dbo.post_master
(
    p_id        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id     INT NOT NULL,
    p_img       NVARCHAR(500) NOT NULL,
    p_desc      NVARCHAR(1000) NULL,
    p_location  NVARCHAR(255) NULL,
    p_date      DATETIME NOT NULL CONSTRAINT DF_post_master_date DEFAULT (GETDATE()),
    p_category  NCHAR(1) NOT NULL
);
GO

CREATE TABLE dbo.comment_master
(
    cmt_id   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id  INT NOT NULL,
    post_id  INT NOT NULL,
    cmt      NVARCHAR(1000) NOT NULL,
    [date]   DATETIME NOT NULL CONSTRAINT DF_comment_master_date DEFAULT (GETDATE())
);
GO

CREATE TABLE dbo.like_master
(
    like_id  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id  INT NOT NULL,
    post_id  INT NOT NULL,
    [date]   DATETIME NOT NULL CONSTRAINT DF_like_master_date DEFAULT (GETDATE()),
    CONSTRAINT UQ_like_master_user_post UNIQUE (user_id, post_id)
);
GO
