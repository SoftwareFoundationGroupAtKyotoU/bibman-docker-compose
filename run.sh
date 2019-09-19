echo $MAILNAME > /etc/mailname
sed -i -e "s/<<smarthost>>/$SMARTHOST/" /etc/exim4/update-exim4.conf.conf
update-exim4.conf
/etc/init.d/exim4 start
cd /var/www/bibman
eval $(opam env)
omake clean
dockerize -wait tcp://postgres:5432
omake
apache2ctl -DFOREGROUND
