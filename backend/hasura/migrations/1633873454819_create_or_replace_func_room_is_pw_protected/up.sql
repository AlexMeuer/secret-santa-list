CREATE OR REPLACE FUNCTION public.room_is_password_protected(room_row room)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
  SELECT room_row.password IS NULL AS BOOLEAN
$function$;
