# Odoo version migration

1. Create your base project, ensure that ODOO_VERSION and TARGET_ODOO_VERSION are set. Activate postgres exposed port (5432). Restore your database and upgrade all modules
2. Create one project and answer questions for each odoo version to jump. Ensure that use external database and point to database created before (Use host ip address and port 5432). Example: if you are migrating to 16.0 from 12.0, you must create 13.0, 14.0, 15.0 and 16.0 projects
3. On target project (16.0 in our example) migrate private modules: invoke module-migrate 12.0 /source-dir/of_modules module1,module2
4. Launch migrate on each version: invoke migrate
5. Read all logs and fix errors on source database
6. Delete failed database
7. Relaunch migration
