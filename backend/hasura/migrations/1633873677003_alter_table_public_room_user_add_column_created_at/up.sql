alter table "public"."room_user" add column "created_at" timestamptz
 not null default now();
