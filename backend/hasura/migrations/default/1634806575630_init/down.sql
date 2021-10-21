
DROP TABLE "public"."room_user_item";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION public.user_is_password_protected(user_row "user")
--  RETURNS boolean
--  LANGUAGE sql
--  STABLE
-- AS $function$
--   SELECT user_row.password IS NOT NULL AS BOOLEAN
-- $function$;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION public.room_is_password_protected(room_row room)
--  RETURNS boolean
--  LANGUAGE sql
--  STABLE
-- AS $function$
--   SELECT room_row.password IS NOT NULL AS BOOLEAN
-- $function$;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."room_user" add column "created_at" timestamptz
--  not null default now();

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."user" add column "created_at" timestamptz
--  not null default now();

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION public.room_is_password_protected(room_row room)
--  RETURNS boolean
--  LANGUAGE sql
--  STABLE
-- AS $function$
--   SELECT room_row.password IS NULL AS BOOLEAN
-- $function$;

alter table "public"."room" alter column "created_at" drop not null;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."room" add column "created_at" timestamptz
--  null default now();

alter table "public"."room_user" rename column "user_name" to "user";

alter table "public"."room_user" rename column "room_name" to "room";

DROP TABLE "public"."room_user";

DROP TABLE "public"."user";

DROP TABLE "public"."room";
