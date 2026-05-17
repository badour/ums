## Cursor Cloud specific instructions

### Project Overview
University Management System (UMS) ERP built with ASP.NET Web Forms (C#), targeting .NET Framework 4.7.2, with SQL Server database. Runs on Linux via Mono + FastCGI + nginx.

### Tech Stack
- **Backend:** ASP.NET Web Forms (C#) on Mono 6.8
- **Frontend:** Bootstrap 5, Font Awesome 6, DataTables, Chart.js, Select2, SweetAlert2, Toastr
- **Database:** SQL Server 2022 (Docker container)
- **Web Server:** FastCGI Mono Server 4 + nginx reverse proxy

### Running the Application

1. **Start Docker + SQL Server:**
   ```
   sudo dockerd &>/tmp/dockerd.log &
   sleep 3
   sudo docker start sqlserver
   ```

2. **Start nginx (if not running):**
   ```
   sudo nginx
   ```

3. **Start FastCGI Mono server:**
   ```
   cd /workspace/UMS
   fastcgi-mono-server4 /applications=/:/workspace/UMS /socket=tcp:127.0.0.1:9000 /verbose=True
   ```

4. **Access at:** `http://localhost:8080/Default.aspx`

### Database
- SQL Server runs in Docker container named `sqlserver` on port 1433
- SA password: `UmsP@ssw0rd!`
- Database name: `UmsDb`
- Schema script: `UMS/Database/ums_schema.sql`
- To recreate DB: `sudo docker exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'UmsP@ssw0rd!' -C -Q "DROP DATABASE UmsDb; CREATE DATABASE UmsDb;"` then run the schema script

### Key Gotchas
- **XSP4 is broken** on Ubuntu 24.04 Mono 6.8 (TLS type-load error). Use `fastcgi-mono-server4` with nginx instead.
- nginx config is at `/etc/nginx/sites-available/ums` -- points root to `/workspace/UMS`.
- Docker requires `fuse-overlayfs` storage driver and `iptables-legacy` in this nested container environment.
- The Web.config connection string uses SQL auth (`User Id=sa;Password=...`) since Linux doesn't support Windows Integrated auth.

### Project Structure
```
UMS/
├── App_Code/           # C# backend (Models, Repositories, Helpers)
├── Database/           # SQL schema and seed scripts
├── assets/
│   ├── css/            # Custom theme CSS
│   ├── js/             # Custom theme JS
│   └── lib/            # Third-party libraries (Bootstrap, FontAwesome, etc.)
├── Site.master         # Master page (sidebar + topbar layout)
├── Default.aspx        # Dashboard page
├── Web.config          # Connection strings and app settings
└── [Module].aspx       # Module pages (Departments, Students, etc.)
```
