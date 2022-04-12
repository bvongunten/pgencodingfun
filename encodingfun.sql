DROP TABLE IF EXISTS public."EncodingFun";

CREATE TABLE IF NOT EXISTS public."EncodingFun"
(
    id integer,
    mytext varchar(50),
    mydata bytea
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."EncodingFun" OWNER to root;

-- Convert VARCHAR bytes to BYTEA
---------------------------------


-- CR / LF / BELL as hex
INSERT INTO public."EncodingFun"(id, mytext) VALUES (1,E'\x0D\x0A\x07');
UPDATE public."EncodingFun" SET mydata =  decode(mytext, 'escape')  where id = 1;

-- CR / LF / BELL as Unicode
INSERT INTO public."EncodingFun"(id, mytext) VALUES (2,E'\u000D\u000A\u0007');
UPDATE public."EncodingFun" SET mydata =  decode(mytext, 'escape')  where id = 2;

-- Some NULL character fun :)
INSERT INTO public."EncodingFun"(id, mydata) VALUES (3, E'\\000\x0D\x0A\x07');


-- How to output text & data as hex (ascii val)
-----------------------------------------------

SELECT id, encode(mytext::bytea, 'hex') as myTextHex, encode(mydata, 'hex') as myDataHex FROM public."EncodingFun";
--SELECT id, encode(mytext::bytea, 'escape') as myTextEscaped, encode(myData, 'escape') as myDataEscaped FROM public."EncodingFun";
