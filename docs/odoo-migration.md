<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<summary>Table of contents</summary>

- [Odoo version migration](#odoo-version-migration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Odoo version migration

1. Create your base project with copier, on questions ensure that ODOO_VERSION and
   TARGET_ODOO_VERSION are set. Activate postgres exposed port (5432).
2. docker compose up -d
3. Restore your database and upgrade all modules
4. Create one project and answer questions for each odoo version to jump. On answers
   ensure that use external database and point to database created before (Use host ip
   address and port 5432). Example: if you are migrating to 16.0 from 12.0, you must
   create 13.0, 14.0, 15.0 and 16.0 projects, TARGET_ODOO_VERSION always will be 16.0
   and change ODOO_VERSION in each project.
5. On target project (16.0 in our example) migrate private modules: invoke
   module-migrate 12.0 /source-dir/of_modules module1,module2
6. Manualy migrate modules. Read docs:

- <https://github.com/OCA/maintainer-tools/wiki/Migration-to-version-17.0>

7. Launch migrate on each version: invoke migrate
8. Read all logs and fix errors on source database
9. Delete failed database
10. Relaunch migration
