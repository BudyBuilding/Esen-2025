# ESEN

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
