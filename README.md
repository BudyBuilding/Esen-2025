# ESEN - PLSQL - Kokas István, Nyeste Szilveszter, Nyakoné Hegedűs-Lukács Mónika

1. Óra Anyaga (SQL bevezetés):
  - Bevezetés - NI 
  - Listázd ki az összes jobot! (wip_discrete_jobs és wip_entities)
  - Listázd ki az egy hónapja nyitott jobokat csökkenő sorrendbe hogy a nullok legyenek elől!
  - Ki hány jobot vágott/módosított valami ilyesmi?
  - Hány szériaszám van jobonként? mtl_serial_numbers, original_wip_entity_id is not null and original_wip_entity_id <> 0
  - Írasd ki minden job idt, job nevet, part numbert, item idt, szériaszámot! 
    	wip_entity_id - wip_discrete_jobs táblából
	    wip_entity_name - wip_entities táblából

2. Óra anyaga (SQL és PLSQL bevezetés):
  - Hozz létre egy sequencet - NEPTUNKÓD_log_seq
  - Irasd ki a következő elemet
  - Hozz létre egy log táblát - NEPTUNKÓD_log_tbl - log_id, created_date, created_by, message, calling_program
  - Adj hozzá rekordot a log táblához
  - Adj hozzá új oszlopot a táblához - Last_update_date, Last_update_by
  - Töröld a calling_program oszlopot (add majd újra hozzá)
  - Készíts egy PLSQL package headert - NEPTUNKÓD_package_pkg
  - Készíts egy PLSQL package bodyt - NEPTUNKÓD_package_pkg
  - Adj hozzá egy Proceduret ami töröl két dátum közti logokat
  - Adj hozzá egy Proceduret ami kilistáz két dátum közti logokat

3. Óra anyaga:
  - Bevezetés EBS - Oracle E-Business Suite
  - Bejelentkezés http://ebz.ni-esen.com:8000
  - Jelszóváltoztatás
  - Sysadmin form letöltés
  - Responsibility adás saját magunknak: Application Developer és Manufacturing, Vision Operations (USA)
  - Készíts egy új copy táblát a wip_discrete_jobs-ról: NEPTUNKÓD_wip_discrete_jobs
  - Készíts egy package headert: NEPTUNKÓD_jobs_pkg
  - Adj hozzá egy log_msg és update_job_qty függvényt
  - Készíts egy package bodyt ugyanazzal a névvel
  - Írd meg a log_msg proceduret, figyelj arra, hogy honnan jön a call, cp vagy anonym block
  - Készítsd el az update_job_qty proceduret is
  - Futtasd az update_job_qty
  - Ellenőrizd, hogy volt e table update

4. Óra anyaga:
  - Bevezetés - Szoftvertesztelés
  - Updateljük a packagünkben szereplő update_job_qty függvényt
  - Addjunk hozzá két új változót: p_out_errbuff, p_out_retcode
  - Fordítsuk be a package headert és a bodyt is

4.1 Konkurans program:
  - Kell egy Program Executable
  - Kellenek paraméterek
  - Konkuren programhoz hozzá kell rendelni a Progrma Executable-t
  - Request grouphoz hozzá kell adni a programunkat
  - Futtathatjuk a requestet

Képekben:
![change_responsibility](https://github.com/user-attachments/assets/fbcd1ad8-425f-42df-89a8-cb54cc932fb8)
![create_program_executable](https://github.com/user-attachments/assets/e6bf82de-4571-402e-84f6-653082c0522f)
![create_concurrent_program](https://github.com/user-attachments/assets/aae48bed-2e2e-465e-bb1f-9f559e2caee3)
![setting_up_the_parameters](https://github.com/user-attachments/assets/09594437-b9c3-4395-863f-062b207f0648)
![assigning_to_request_group](https://github.com/user-attachments/assets/cb0ff22b-106b-41ac-897e-41832e1dc244)
![run_the_cp](https://github.com/user-attachments/assets/625ccc5c-6c20-4181-a218-a9ac846fcc3d)


5. Gyakorlás a zh-ra:
Jelentkezz be APPS account-al az adatbázisra.

Csinálj copy-t a következő táblákról, minden tábla neve kezdődjön a neptunkódoddal (pl.: NEPTUN_OE_ORDER_HEADERS_ALL): oe_order_lines_all, oe_order_headers_all, mtl_system_items_b (10 pont)

Minden tábla esetében használd ezeket a másolat táblákat.

Csinálj egy package-et (legyen pks és pkb file-od is. Az üres package is pontot ér ha befordul). (10 pont)

A package tartalmazzon egy privát FUNCTIONT (a function nevének első 5 karaktere tartalmazza a neptunkódod), amely 2 bemenő paraméter alapján (p_in_line_id és p_in_days) Az adott line-hoz tartozó schedule_arrival_date és az ahhoz hozzáadott days-ből egy dátummal tér vissza. pl.: schedule_arrival_date = 28-OCT-04 és napok = 1 akkor return = 29-OCT-04 (10 pont) (bármilyen exception kezelés extra pontot jelent) (5 pont extra)

Tartalmazzon a package egy PROCEDURE-t amely ezeket a paramétereket használja (a procedure nevének első 5 karaktere tartalmazza a neptunkódod):

PROCEDURE neptun_shift_schedule_arrival_date(p_out_errbuff OUT VARCHAR2,p_out_retcode OUT NUMBER,p_in_order_number IN NUMBER,p_in_days IN NUMBER)

A procedure egy CURSOR-ba szedje össze az adott ORDER_NUMBER-hez tartozó összes line-t és egy ciklusban frissítsük a 4. feladatban megadott function használatával azokat. A program futása közben az output-ra írjuk ki a módosított order header_id-ját, valamint minden line esetében az ahhoz tartozó part_numbert (mtl_system_items_b-ben a segment1) valamint a hozzá tartozó description-t és eredeti valamint módosított dátumot. A log file-ba írjuk be az érintett sorok line_id-ját valamint az eredeti és új dátumot. (10 pont) (Exception kezelés extra pontot jelent) (5 pont extra)

Fordítsd be a package-et

Csináljunk hozzá konkurens programot. (40 pont)
