FROM wordpress:latest

RUN apt-get update && apt-get install -y unzip curl && rm -rf /var/lib/apt/lists/*

# Install pg4wp
RUN curl -fsSL https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress/archive/refs/heads/master.zip -o /tmp/pg4wp.zip \
  && unzip /tmp/pg4wp.zip -d /tmp \
  && cp -r /tmp/postgresql-for-wordpress-master/pg4wp /var/www/html/wp-content/ \
  && cp /tmp/postgresql-for-wordpress-master/pg4wp/db.php /var/www/html/wp-content/db.php \
  && rm -rf /tmp/pg4wp.zip /tmp/postgresql-for-wordpress-master
