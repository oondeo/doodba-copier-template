<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<summary>Table of contents</summary>

- [Odoo version migration](#odoo-version-migration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Odoo version migration

1. Create your base project with copier, on questions ensure that ODOO_VERSION and
   TARGET_ODOO_VERSION are set.
2. docker compose up -d
3. Restore your database and upgrade all modules
4. invoke migrate-dump
5. Create one project per odoo version to migrate and answer questions for each odoo
   version to jump. Example: if you are migrating to 16.0 from 12.0, you must create
   13.0, 14.0, 15.0 and 16.0 projects, TARGET_ODOO_VERSION always will be 16.0 and
   change ODOO_VERSION in each project. Example commands (change odoo_version before
   cp):

```bash

cp project/.copier-answers.yml answers.yml
mkdir odoo13
sed 's/^odoo_version:.*/odoo_version: 13.0/' answers.yml > odoo13/.copier-answers.yml
copier recopy --vcs-ref oondeo --trust -A odoo13
mkdir odoo14
sed 's/^odoo_version:.*/odoo_version: 14.0/' answers.yml > odoo14/.copier-answers.yml
copier recopy --vcs-ref oondeo --trust -A odoo14
mkdir odoo15
sed 's/^odoo_version:.*/odoo_version: 15.0/' answers.yml > odoo15/.copier-answers.yml
copier recopy --vcs-ref oondeo --trust -A odoo15
mkdir odoo16
sed 's/^odoo_version:.*/odoo_version: 16.0/' answers.yml > odoo16/.copier-answers.yml
copier recopy --vcs-ref oondeo --trust -A  odoo16

```

5. On target project (16.0 in our example) migrate private modules: invoke
   module-migrate 12.0 /source-dir/of_modules module1,module2
6. Manualy migrate modules. Read docs:

- <https://github.com/OCA/maintainer-tools/wiki/Migration-to-version-17.0>

7. Build first version:

```bash
cd odoo13
invoke migrate-build
```

8. Launch migration:

```bash
cd odoo13
invoke migrate
```

8. Read all logs from container and database container and fix errors on database. Copy
   these fixes to a sql script and apply to original database after all process
9. Launch migrate again
10. Dump database to next step

```bash
invoke migrate-dump
```

11. Go to next version and repeat steps 7-10
12. Apply all fixes to original database
