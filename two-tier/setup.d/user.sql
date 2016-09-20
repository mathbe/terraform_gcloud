DROP DATABASE IF EXISTS guestbook;

CREATE DATABASE guestbook;

GRANT ALL PRIVILEGES ON guestbook.* to guestbook@'10.10.10.%' identified by 'Iewypj2Ck2jY';
