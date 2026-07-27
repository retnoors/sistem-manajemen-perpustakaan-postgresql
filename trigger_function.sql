----------------------------------------------------
--- 1. FUNCTION: production.fnc_add_cred_login() ---
----------------------------------------------------

-- DROP FUNCTION IF EXISTS production.fnc_add_cred_login();

CREATE OR REPLACE FUNCTION production.fnc_add_cred_login()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF NEW.password IS NULL THEN
        NEW.password := crypt('Password1', gen_salt('bf'));
    ELSE
        NEW.password := crypt(NEW.password, gen_salt('bf'));
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION production.fnc_add_cred_login()
    OWNER TO mtr_library;

----------------------------------------------------
-- 2. FUNCTION: production.fnc_gen_iduser()
----------------------------------------------------

-- DROP FUNCTION IF EXISTS production.fnc_gen_iduser();

CREATE OR REPLACE FUNCTION production.fnc_gen_iduser()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF NEW.is_admin = TRUE THEN
        NEW.id_user := 'ADM' || nextval('production.seq_iduser');
    ELSE
        NEW.id_user := 'USR' || nextval('production.seq_iduser');
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION production.fnc_gen_iduser()
    OWNER TO mtr_library;
