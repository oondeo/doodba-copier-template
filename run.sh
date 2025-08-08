#!/bin/bash

NAME=$(basename $PWD)
ROOT=/var/lib/chroot/$NAME
cp /etc/resolv.conf $ROOT/etc/
cp /etc/hosts $ROOT/etc/
sed  's/^odoo(.*)false$/\\1bash/g' $ROOT/etc/password
cat > $ROOT/start.sh <<- STARFILE
#!/bin/bash
source /Envfile
/opt/odoo/common/entrypoint /usr/local/bin/odoo

STARFILE
chmod +x $ROOT/start.sh
mkdir -p $ROOT $ROOT/opt/odoo/custom $ROOT/opt/odoo/auto/addons
chown 1000 $ROOT/opt/odoo/custom $ROOT/opt/odoo/auto $ROOT/opt/odoo/auto/addons
mount --rbind odoo/custom $ROOT/opt/odoo/custom
mount --rbind odoo/auto $ROOT/opt/odoo/auto
cd $ROOT
mount -t proc /proc proc/
mount --rbind /sys sys/
mount --rbind /dev dev/
#mount --bind /dev/pts dev/pts

chroot $ROOT su odoo -c /start.sh > $ROOT/var/log/odoo.log 2>&1
#chroot $ROOT bash
