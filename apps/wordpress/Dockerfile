FROM wordpress:latest

# Install pg4wp
RUN curl -fsSL https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress/archive/refs/heads/v3.zip -o /tmp/pg4wp.zip \
  && unzip /tmp/pg4wp.zip -d /tmp \
  && cp -r /tmp/postgresql-for-wordpress-v3/pg4wp /var/www/html/wp-content/ \
  && cp /tmp/postgresql-for-wordpress-v3/pg4wp/db.php /var/www/html/wp-content/db.php \
  && rm -rf /tmp/pg4wp.zip /tmp/postgresql-for-wordpress-v3
