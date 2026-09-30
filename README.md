# Skroll

**Skroll** is a social-networking web application developed as an academic project during the fifth semester of my Bachelor of Computer Applications (BCA).

The project was originally started before the semester began using **Visual Studio 2022**. After the semester started, it was adapted to work with **Microsoft Visual Web Developer 2010**, which was the development environment used during the course.

Skroll was designed as an experimental social-media platform featuring user accounts, profiles, posts, comments, likes, followers, and media sharing.

## Features

- User registration and login
- User profile management
- Profile pictures
- Social-media-style dashboard
- Photo posts
- Video posts
- Post feed
- Comments
- Likes
- Followers and following
- User post counts
- Profile-based post viewing
- Password recovery workflow
- SQL Server database integration

## Technologies Used

- ASP.NET Web Forms
- VB.NET
- HTML
- CSS
- JavaScript
- Microsoft SQL Server
- Visual Studio
- Microsoft Visual Web Developer 2010

## Development Background

Skroll was started in **Visual Studio 2022** during the vacation before Semester 5 began.

The original database was created directly inside the ASP.NET project using:

```text
Add New Item
→ Data
→ SQL Server Database
→ skroll.mdf
```

The database was stored inside the project's `App_Data` directory.

After the semester began, the project was adapted to the older Microsoft Visual Web Developer 2010 environment used during coursework.

Because much of Skroll had already been developed before several later ASP.NET topics were taught, some validation, security, and production-level functionality was outside the scope of the original project.

The repository therefore preserves Skroll primarily as an **academic and portfolio project**, rather than attempting to redesign it as a modern production social-media application.

## Repository Structure

```text
Skroll/
│
├── README.md
├── .gitignore
├── tybca21_project_sem-v.sln
│
└── tybca21_project_sem-v/
    │
    ├── tybca21_project_sem-v.vbproj
    ├── Web.config
    │
    ├── App_Data/
    │   └── skroll_schema.sql
    │
    ├── images/
    ├── videos/
    │
    ├── signup.aspx
    ├── login.aspx
    ├── dashboard.aspx
    ├── profile.aspx
    ├── forgot.aspx
    │
    ├── *.aspx.vb
    ├── *.designer.vb
    └── other application files
```

## Database

Skroll uses a **file-based Microsoft SQL Server database**.

The original project uses:

```text
App_Data/skroll.mdf
```

The database is intended to remain inside the project rather than requiring a separately configured production database server.

### Creating the Database

If `skroll.mdf` is not included in the repository, create it manually in Visual Studio.

Inside the project:

```text
App_Data
→ Add
→ New Item
→ SQL Server Database
```

Name the database:

```text
skroll.mdf
```

Then execute:

```text
App_Data/skroll_schema.sql
```

against the newly created database.

The schema creates the main tables required by Skroll:

```text
user_info
social_network
post_master
comment_master
like_master
```

## Running the Project

### Recommended Environment

- Windows
- Visual Studio 2022
- ASP.NET / .NET Framework development tools
- Microsoft SQL Server LocalDB or compatible SQL Server components
- Modern web browser

### Steps

1. Clone or download the repository.
2. Open `tybca21_project_sem-v.sln` in Visual Studio.
3. Make sure the required ASP.NET/.NET Framework components are installed.
4. Create `App_Data/skroll.mdf` if it is not already present.
5. Run `skroll_schema.sql` against the database.
6. Build and run the application.
7. Create test accounts through the Signup page.

## Demo Data

Any accounts, profile images, posts, comments, likes, or other content included with the project should be treated as **fictional test data** created only to demonstrate the application.

Real account credentials or personal information should not be used when testing the project.

## Important Notes

Skroll is an academic project and should not be treated as a production-ready social-networking platform.

Some implementation choices reflect the concepts, technologies, and coursework available during the original development period.

Known limitations include:

- Legacy ASP.NET Web Forms architecture
- Basic form validation in some areas
- Authentication and password handling designed for academic demonstration rather than production security
- Limited input sanitization and security hardening
- Simplified social-networking functionality
- No production deployment configuration
- Limited responsive/mobile optimization

These limitations have intentionally not been completely redesigned so that the repository continues to represent the original project and development stage accurately.

## Security Notice

Do not use real passwords, email credentials, personal information, or private media when testing Skroll.

The public repository should contain only:

- Source code
- Application assets
- Database schema
- Fictional/demo data
- Non-sensitive configuration

Real SMTP passwords, API keys, personal databases, and other credentials should never be committed to the repository.

## Project Status

**Completed Academic Project**

The core development of Skroll is complete.

The repository is preserved primarily to demonstrate earlier experience with:

- ASP.NET Web Forms
- VB.NET
- SQL Server databases
- User authentication
- Database-driven web applications
- Social-network-style application design
- File and media uploads
- Relational data management

## Purpose

Skroll is maintained as part of my software-development portfolio and represents an early attempt to build a database-driven social-networking application beyond the minimum requirements of a semester project.
