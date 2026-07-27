--------------- LOGIN Structure -----------------

--1. Insert Data pada tabel mst_user untuk detail user
INSERT INTO production.mst_user(
	npm, name, email, phone)
	VALUES (35653534, 'Galgadot', 'Galgadot@gmail.com', 0821256434544);

INSERT INTO production.mst_user(
	npm, name, email, phone)
	VALUES (23453565, 'El Botuna', 'botuna.el@gmail.com', 0821256478926);

INSERT INTO production.mst_user(
	npm, name, email, phone)
	VALUES (56789045, 'Rahmadewi', 'Rahmadewi1@gmail.com', 085845698877);
	
INSERT INTO production.mst_user(
	npm, name, email, phone)
	VALUES (78901234, 'Nadya Saras', 'Nadyas@gmail.com', 085845698877);

select * from production.mst_user

select * from production.mst_user_login

--2. Create new login account based on Roles
INSERT INTO production.mst_user_login(
	npm, username, password, is_admin)
	VALUES (35653534, 'Galgadot', 'admin321', TRUE);

INSERT INTO production.mst_user_login(
	npm, username, password)
	VALUES (23453565, 'El Botuna', 'admin123');
	
INSERT INTO production.mst_user_login(
	npm, username, password)
	VALUES (78901234, 'Nadyaas', 'admin654');
	
INSERT INTO production.mst_user_login(
	npm, username, password)
	VALUES (56789045, 'Rahmadewi1', 'admin456');