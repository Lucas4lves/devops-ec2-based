FROM wordpress:latest

# Install pg4wp
RUN git clone --depth=1 --branch v3 https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress.git /tmp/pg4wp \
  && cp -r /tmp/pg4wp/pg4wp /var/www/html/wp-content/ \
  && cp /tmp/pg4wp/pg4wp/db.php /var/www/html/wp-content/db.php \
  && rm -rf /tmp/pg4wp
