create table covid19.dcml_items (
    item_id         integer primary key,
    title           text not null,
    slug            text not null,
    created_at      timestamp with time zone not null,
    updated_at      timestamp with time zone not null,
    pg_cnt          integer not null,
    file_hash       text,
    related_article text,
    data_tags       text not null,
    canonical_url   text not null,
    projects        text,
    covid_mentioned boolean not null,
    subset          text check (subset in ('test','train'))
    );
comment on table covid19.dcml_items is
'Metadata for the DocumentCloud docs downloaded for machine learning purposes.';

create table covid19.dcml_pdfs (
    item_id         integer     primary key,
	processed       timestamp with time zone not null default current_timestamp,
	filename        text        not null,
    pg_cnt          integer     not null,
    size            integer     not null
    );
comment on column covid19.dcml_pdfs.size is 'Size of PDF in bytes';

create table covid19.dcml_pdfpages (
    item_id         integer     not null
                    references  covid19.dcml_pdfs,
    pg              integer     not null,
    word_cnt        integer     not null,
    char_cnt        integer     not null,
    body            text,
    primary key (item_id, pg)
    );
-- 
alter table covid19.dcml_pdfs add foreign key (item_id)
   references covid19.dcml_items;
