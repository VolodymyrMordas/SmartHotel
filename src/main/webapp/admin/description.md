# mysql

mysql> create table if not exists figure(id integer primary key auto_increment, type integer, param_a integer,param_b integer,param_c integer, color varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> describe figure;
+---------+-------------+------+-----+---------+----------------+
| Field   | Type        | Null | Key | Default | Extra          |
+---------+-------------+------+-----+---------+----------------+
| id      | int(11)     | NO   | PRI | NULL    | auto_increment |
| type    | int(11)     | YES  |     | NULL    |                |
| param_a | int(11)     | YES  |     | NULL    |                |
| param_b | int(11)     | YES  |     | NULL    |                |
| param_c | int(11)     | YES  |     | NULL    |                |
| color   | varchar(10) | YES  |     | NULL    |                |
+---------+-------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> create table if not exists figure_type(id integer primary key auto_increment, type_descr varchar(50));
Query OK, 0 rows affected (0.02 sec)

mysql> describe figure_type;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int(11)     | NO   | PRI | NULL    | auto_increment |
| type_descr | varchar(50) | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> insert into figure_type(type_descr) values('circle'),('square'),('triangle');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from figure_type;
+----+------------+
| id | type_descr |
+----+------------+
|  1 | circle     |
|  2 | square     |
|  3 | triangle   |
+----+------------+
3 rows in set (0.00 sec)

mysql> insert into figure(type,param_a,color) values(1,12,'#D12112'),(1,21,'#AABAA3');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into figure(type,param_a,param_b,color) values(2,12,7,'#DF00FF'),(2,21,5,'#AACC23');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into figure(type,param_a,param_b,param_c,color) values(3,12,7,11,'#DFAACC'),(3,21,17,19,'#AAB123');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from figure;
+----+------+---------+---------+---------+---------+
| id | type | param_a | param_b | param_c | color   |
+----+------+---------+---------+---------+---------+
|  1 |    1 |      12 |    NULL |    NULL | #D12112 |
|  2 |    1 |      21 |    NULL |    NULL | #AABAA3 |
|  3 |    2 |      12 |       7 |    NULL | #DF00FF |
|  4 |    2 |      21 |       5 |    NULL | #AACC23 |
|  5 |    3 |      12 |       7 |      11 | #DFAACC |
|  6 |    3 |      21 |      17 |      19 | #AAB123 |
+----+------+---------+---------+---------+---------+
6 rows in set (0.00 sec)


mysql> alter table figure add constraint fk_figure_type foreign key (type) references figure_type(id) on delete cascade;
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> describe figure;
+---------+-------------+------+-----+---------+----------------+
| Field   | Type        | Null | Key | Default | Extra          |
+---------+-------------+------+-----+---------+----------------+
| id      | int(11)     | NO   | PRI | NULL    | auto_increment |
| type    | int(11)     | YES  | MUL | NULL    |                |
| param_a | int(11)     | YES  |     | NULL    |                |
| param_b | int(11)     | YES  |     | NULL    |                |
| param_c | int(11)     | YES  |     | NULL    |                |
| color   | varchar(10) | YES  |     | NULL    |                |
+---------+-------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> describe figure_type;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int(11)     | NO   | PRI | NULL    | auto_increment |
| type_descr | varchar(50) | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)



