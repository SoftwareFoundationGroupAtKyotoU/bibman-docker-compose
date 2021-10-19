CREATE OR REPLACE FUNCTION can_convert_sjis(txt TEXT)
RETURNS BOOLEAN AS $$
DECLARE
sjis_name text;
BEGIN
sjis_name := convert_to(txt,'shift_jis');
RETURN true;
EXCEPTION
WHEN OTHERS THEN
RETURN false;
END;
$$ LANGUAGE plpgsql;
