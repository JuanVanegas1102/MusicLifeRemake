/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     16/01/2024 06:37:56 p. m.                    */
/*==============================================================*/


alter table COMMENTS
   drop constraint FK_COMMENTS_CAN_USER;

alter table COMMENTS
   drop constraint FK_COMMENTS_HAS_SONG;

alter table PLAYLIST
   drop constraint FK_PLAYLIST_CREATES_USER;

alter table PLAYLISTCONTENT
   drop constraint FK_PLAYLIST_COMPOSES_SONG;

alter table PLAYLISTCONTENT
   drop constraint FK_PLAYLIST_ESPECIFIE_PLAYLIST;

alter table SONG
   drop constraint FK_SONG_OWNS_USER;

alter table "USER"
   drop constraint FK_USER_CATALOG_USERTYPE;

drop index HAS_FK;

drop index CAN_FK;

drop table COMMENTS cascade constraints;

drop index CREATES_FK;

drop table PLAYLIST cascade constraints;

drop index COMPOSES_FK;

drop index ESPECIFIES_FK;

drop table PLAYLISTCONTENT cascade constraints;

drop index OWNS_FK;

drop table SONG cascade constraints;

drop index CATALOG_FK;

drop table "USER" cascade constraints;

drop table USERTYPE cascade constraints;

/*==============================================================*/
/* Table: COMMENTS                                              */
/*==============================================================*/
create table COMMENTS 
(
   COMMENTID            VARCHAR2(15)         not null,
   USERID               VARCHAR2(15)         not null,
   SONGID               VARCHAR2(15)         not null,
   DESCRIPTION          VARCHAR2(250)        not null,
   constraint PK_COMMENTS primary key (COMMENTID)
);

/*==============================================================*/
/* Index: CAN_FK                                                */
/*==============================================================*/
create index CAN_FK on COMMENTS (
   USERID ASC
);

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on COMMENTS (
   SONGID ASC
);

/*==============================================================*/
/* Table: PLAYLIST                                              */
/*==============================================================*/
create table PLAYLIST 
(
   PLAYLISTID           VARCHAR2(15)         not null,
   USERID               VARCHAR2(15)         not null,
   PLAYLISTNAME         VARCHAR2(60)         not null,
   constraint PK_PLAYLIST primary key (PLAYLISTID)
);

/*==============================================================*/
/* Index: CREATES_FK                                            */
/*==============================================================*/
create index CREATES_FK on PLAYLIST (
   USERID ASC
);

/*==============================================================*/
/* Table: PLAYLISTCONTENT                                       */
/*==============================================================*/
create table PLAYLISTCONTENT 
(
   IDCONTENT            VARCHAR2(15)         not null,
   PLAYLISTID           VARCHAR2(15)         not null,
   SONGID               VARCHAR2(15)         not null,
   constraint PK_PLAYLISTCONTENT primary key (IDCONTENT)
);

/*==============================================================*/
/* Index: ESPECIFIES_FK                                         */
/*==============================================================*/
create index ESPECIFIES_FK on PLAYLISTCONTENT (
   PLAYLISTID ASC
);

/*==============================================================*/
/* Index: COMPOSES_FK                                           */
/*==============================================================*/
create index COMPOSES_FK on PLAYLISTCONTENT (
   SONGID ASC
);

/*==============================================================*/
/* Table: SONG                                                  */
/*==============================================================*/
create table SONG 
(
   SONGID               VARCHAR2(15)         not null,
   USERID               VARCHAR2(15)         not null,
   SONGNAME             VARCHAR2(100)        not null,
   SONGGENRE            VARCHAR2(60)         not null,
   SONGURL              VARCHAR2(255)        not null,
   constraint PK_SONG primary key (SONGID)
);

/*==============================================================*/
/* Index: OWNS_FK                                               */
/*==============================================================*/
create index OWNS_FK on SONG (
   USERID ASC
);

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" 
(
   USERID               VARCHAR2(15)         not null,
   USERTYPEID           VARCHAR2(3)          not null,
   USERNAME             VARCHAR2(100)        not null,
   PASSWORD             VARCHAR2(25)         not null,
   PROFILEPICTURE       VARCHAR2(255),
   constraint PK_USER primary key (USERID)
);

/*==============================================================*/
/* Index: CATALOG_FK                                            */
/*==============================================================*/
create index CATALOG_FK on "USER" (
   USERTYPEID ASC
);

/*==============================================================*/
/* Table: USERTYPE                                              */
/*==============================================================*/
create table USERTYPE 
(
   USERTYPEID           VARCHAR2(3)          not null,
   DESCRIPTION          VARCHAR2(30)         not null,
   constraint PK_USERTYPE primary key (USERTYPEID)
);

alter table COMMENTS
   add constraint FK_COMMENTS_CAN_USER foreign key (USERID)
      references "USER" (USERID);

alter table COMMENTS
   add constraint FK_COMMENTS_HAS_SONG foreign key (SONGID)
      references SONG (SONGID);

alter table PLAYLIST
   add constraint FK_PLAYLIST_CREATES_USER foreign key (USERID)
      references "USER" (USERID);

alter table PLAYLISTCONTENT
   add constraint FK_PLAYLIST_COMPOSES_SONG foreign key (SONGID)
      references SONG (SONGID);

alter table PLAYLISTCONTENT
   add constraint FK_PLAYLIST_ESPECIFIE_PLAYLIST foreign key (PLAYLISTID)
      references PLAYLIST (PLAYLISTID);

alter table SONG
   add constraint FK_SONG_OWNS_USER foreign key (USERID)
      references "USER" (USERID);

alter table "USER"
   add constraint FK_USER_CATALOG_USERTYPE foreign key (USERTYPEID)
      references USERTYPE (USERTYPEID);

