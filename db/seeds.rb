sql_query = <<-SQLQUERY

DROP TABLE IF EXISTS nfl_suspensions;

create table nfl_suspensions(
	id bigserial primary key,
	name varchar(255) NOT NULL,
	team varchar(255) NOT NULL,
	games varchar(255) NOT NULL,
	category varchar(255) NOT NULL,
	description varchar(255) NULL,
	year varchar(255) NOT NULL,
	source varchar(255) NOT NULL
);


COPY nfl_suspensions ("name","team","games","category","description","year","source") FROM '#{Rails.root}/nfl_suspensions.csv' DELIMITER ',' CSV HEADER;

SQLQUERY

ActiveRecord::Base.connection.execute(sql_query)

sql_query = "select * from nfl_suspensions"

records = ActiveRecord::Base.connection.execute(sql_query)
